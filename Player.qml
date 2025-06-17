import QtQuick
import QtQuick.Controls

Item {
    id: player
    width: 64
    height: 64
    x: 1290
    y: 755
    focus: true

    property string direction: "down"
    property bool moving: false
    property int baseSpeed: 4
    property real currentSpeed: baseSpeed
    property var activeBuffs: ({})

    //角色属性
    property real maxHealth: 100
    property real health: maxHealth
    property real maxMana: 500
    property int money:1000

    property int defense: 10

    property ListModel bag: ListModel{
        ListElement{icon:"qrc:/weapons/knife.png"; name:"匕首";count:1}
        ListElement{
            itemId:"wings"
            icon:"qrc:/weapons/wings.png";
            name: "伊卡洛斯的羽翼";
            count:2;
            type:"buff"
            buffType:"speed"
            value:2
            duration:10000
        }
    }

    AnimatedSprite {
        id: playerSprite
        anchors.fill: parent
        frameCount: 3
        frameWidth: 64
        frameHeight: 64
        frameRate: 8
        source: "qrc:/sprites/player_spritesheet.png"
        interpolate: false

        frameX: {
            var frameXOffset = 0
            switch(player.direction) {
                case "down": frameXOffset = 0; break
                case "left": frameXOffset = 64; break
                case "right": frameXOffset = 128; break
                case "up": frameXOffset = 192; break
            }
            return frameXOffset + (player.animState * 64)
        }

        frameY: {
            switch(player.direction) {
                case "down": return 0
                case "left": return frameHeight
                case "right": return frameHeight * 2
                case "up": return frameHeight * 3
                default: return 0
            }
        }
        running: player.moving
    }

    Timer {
        id: movementTimer
        interval: 16
        running: true
        repeat: true
        onTriggered: {
            var newX = player.x
            var newY = player.y
            var moved = false

            if (Qt.Key_W in pressedKeys) {
                moved = true
                newY -= player.currentSpeed
                player.direction = "up"
            }
            if (Qt.Key_S in pressedKeys) {
                moved = true
                newY += player.currentSpeed
                player.direction = "down"
            }
            if (Qt.Key_A in pressedKeys) {
                moved = true
                newX -= player.currentSpeed
                player.direction = "left"
            }
            if (Qt.Key_D in pressedKeys) {
                moved = true
                newX += player.currentSpeed
                player.direction = "right"
            }

            player.moving = moved

            if (moved && canMove(newX, newY)) {
                player.x = newX
                player.y = newY
            }
        }
    }

    Rectangle{
        id:playerBag
        visible:false
        width: 500
        height: 500
        color: "#AA333333"

        Rectangle {
            id:healthBar
            x:390
            y:50
            z:1
            width: 50
            height: 8
            radius: 4
            color: "#442222"

            Rectangle {
                width: (parent.width * player.health / player.maxHealth)
                height: parent.height
                radius: parent.radius
                color: "#FF5555"
                Behavior on width {
                    NumberAnimation { duration: 300 }
                }
            }

            Text {
                id: healthText
                anchors.centerIn: parent
                text:`${player.health}/${player.maxHealth}`
                color: {
                    if(player.health < player.maxHealth * 0.3) "red"
                    else if(player.health < player.maxHealth * 0.6) "orange"
                    else "white"
                }
                font.pixelSize: 10

                Behavior on text {
                    NumberAnimation{ duration:300}
                }
            }
        }

        Text{
            id:palyerMoney
            text:player.money
            x:320
            y:82
            color: "gold"
            font.bold: true
            font.pixelSize: 10

            Behavior on text {
                SequentialAnimation{
                    NumberAnimation{
                        property:  "scale"; to: 1.2; duration: 200
                    }
                    NumberAnimation{
                        property: "scale"; to: 1.0; duration: 200
                    }
                }
            }
        }

        Image {
            anchors.fill: parent
            source: "qrc:/Chara/menu.png"
        }

        GridView{
            anchors.fill: parent
            cellWidth: 64
            cellHeight: 64

            topMargin: 170
            leftMargin: 30

            model: player.bag
            delegate: Item{

                anchors.margins: 20
                width: 64
                height: 64

                Image {
                    source:icon
                    anchors.centerIn: parent
                }

                Column{
                    anchors{
                        bottom: parent.bottom
                        horizontalCenter: parent.horizontalCenter
                    }
                    spacing: 1

                    Text {
                        text:name
                        color: "white"
                        font.pixelSize: 10
                        horizontalAlignment: Text.AlignHCenter
                }
                    Text{
                        text:count
                        color: "red"
                        font.pixelSize: 10
                        horizontalAlignment: Text.AlignHCenter
                    }
}
                MouseArea{
                    anchors.fill: parent
                    onClicked: player.useItem(index)
                }
            }
        }
    }

    function useItem(index){
        var item = bag.get(index)
        if(item.type === "buff" && item.buffType === "speed"){
            activeBuffs["wings"] = {
                value: item.value,
                expiry: new Date().getTime() + item.duration
            };
            accelerate();

            wingsTimer.start();
            }

        if(bag.get(index).count >0){
            bag.setProperty(index, "count", bag.get(index).count - 1)
            if(bag.get(index).count <=0){
                bag.remove(index)
            }
        }
    }

    function accelerate(){
        var Magnification = 1.0;
        if(activeBuffs["wings"]){
            Magnification = 2;
        }
        currentSpeed = baseSpeed  * Magnification;
    }

    Timer{
        id:wingsTimer
        interval: 1000
        repeat: true
        onTriggered: {
            var now = new Date().getTime();
            if(!activeBuffs["wings"] || now >activeBuffs["wings"].expiry){
                delete activeBuffs["wings"];
                accelerate();
                stop();
            }
        }
    }

    property var pressedKeys: ({})

    Keys.onPressed: function(event) {
        if(event.key === Qt.Key_E){
            showDialogue()
        }

        if(event.key === Qt.Key_B){
            playerBag.visible = !playerBag.visible
            event.accepted = true;
        }else if(event.key === Qt.Key_Escape && playerBag.visible){
            playerBag.visible = false
        }

        pressedKeys[event.key] = true
        event.accepted = true
    }

    Keys.onReleased: function(event) {

        delete pressedKeys[event.key]
        if (Object.keys(pressedKeys).length === 0) {
            player.moving = false
        }
        event.accepted = true
    }



    // 碰撞检测
    function canMove(x, y) {

        var bounds = parent.parent || parent
        return x >= 0 && y >= 0 &&
               x <= bounds.width - width &&
               y <= bounds.height - height

    }

    //区域检测

}
