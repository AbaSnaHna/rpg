import QtQuick
import QtQuick.Controls

Item {
    id: player
    width: 64
    height: 64
    x: 1290
    y: 755
    focus: true

    property var playerData: PlayerData

    property string direction: "down"
    property bool moving: false
    property bool attacking: false
    property int baseSpeed: 4
    property real currentSpeed: baseSpeed

    property var activeBuffs: ({})

    AnimatedSprite {
        id: playerSprite
        anchors.fill: parent
        frameCount: 3
        frameWidth: 48
        frameHeight: 48
        frameRate: 8
        source: "qrc:/sprites/player_spritesheet1.png"
        interpolate: false
        visible: !player.attacking

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
        running: player.moving && !player.attacking
    }

    AnimatedSprite{
        id:attackSprite
        anchors.fill: parent
        frameCount: 51
        frameWidth: 64
        frameHeight: 64
        frameRate: 12
        source: "qrc:/sprites/battle.png"
        interpolate: false
        running: player.attacking
        visible: player.attacking

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
                player.direction = "up"
                newY -= player.currentSpeed
            }
            if (Qt.Key_S in pressedKeys) {
                moved = true
                player.direction = "down"
                newY += player.currentSpeed
            }
            if (Qt.Key_A in pressedKeys) {
                moved = true
                player.direction = "left"
                newX -= player.currentSpeed
            }
            if (Qt.Key_D in pressedKeys) {
                moved = true
                player.direction = "right"
                newX += player.currentSpeed
            }

            if(Qt.Key_J in pressedKeys){
                player.attacking = true
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
                width: (parent.width * playerData.currentHealth / playerData.maxHealth)
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
                text:`${playerData.currentHealth}/${playerData.maxHealth}`
                color: {
                    if(playerData.currentHealth < playerData.maxHealth * 0.3) "red"
                    else if(playerData.currentHealth < playerData.maxHealth * 0.6) "orange"
                    else "white"
                }
                font.pixelSize: 10

                Behavior on text {
                    NumberAnimation{ duration:300}
                }
            }
        }

        Text{
            id:playerMoney
            text:playerData.money
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

            model: playerData.bag
            delegate: Item{

                anchors.margins: 20
                width: 64
                height: 64

                MouseArea{
                    onClicked: {
                        rangeEffect.visible = true;
                        rangeEffect.x = itemIcon.x - 10;
                        rangeEffect.y = itemIcon.y - 10;
                        rangeEffect.width = itemIcon.width + 20;
                        rangeEffect.height = itemIcon.height + 20;
                        rangeEffectTimer.start();
                    }
                }

                Image {
                    id:itemIcon
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
                    onClicked: {
                        player.useItem(index)
                    }
                }
            }
        }
    }

    Rectangle {
        id: rangeEffect
        visible: false
        color: "transparent"
        border.color: "yellow"
        border.width: 2
        radius: 5
    }

    Timer {
        id: rangeEffectTimer
        interval: 1000
        onTriggered: {
            rangeEffect.visible = false;
        }
    }

    Text {
        id: boostText
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        y: 50
        color: "white"
        font.pixelSize: 16
        font.bold: true
        visible: false
        text: "装备匕首！攻击力增加！"
    }

    Text {
        id: accelerateText
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        y: 50
        color: "white"
        font.pixelSize: 16
        font.bold: true
        visible: false
        text: "速度提升！"
    }

    Text{
        id:healingText
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        y: 50
        color: "white"
        font.pixelSize: 16
        font.bold: true
        visible: false
        text: "生命恢复！"
    }

    function useItem(index){
        var item = playerData.bag.get(index)
        if(item.type === "buff" && item.buffType === "speed"){
            activeBuffs["wings"] = {
                value: item.value,
                expiry: new Date().getTime() + item.duration
            };
            accelerateText.visible = true
            accelerate()
            accelerateTimer.start()
            wingsTimer.start()
            }

        if(item.type === "buff" && item.buffType === "attack"){
            activeBuffs["knife"]= {
                value:item.value
            };
            boostText.visible = true
            boostTimer.start()
            boost()
        }

        if(item.type === "buff" && item.buffType === "healing"){
            if (playerData.health == playerData.maxHealth) {
                        healText.visible = true
                        healText.text = "血量已满，无法使用药水！"
                        healText.color = "red"
                        healTimer.start()
                        return;
            }
            activeBuffs["potion"] = {
                value:item.value
            };
            healingText.visible = true
            healingTimer.start()
            healing()
        }

        if(playerData.bag.get(index).count >0){
            playerData.bag.setProperty(index, "count", playerData.bag.get(index).count - 1)
            if(playerData.bag.get(index).count <=0){
                playerData.bag.remove(index)
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

    function boost(){
        var Magnification = 10
        if(activeBuffs["knife"]){
            Magnification = 20
        }
        playerData.currentAttack += Magnification

    }

    function healing(){
        var Magnification = 10
        if(activeBuffs["potion"]){
            Magnification = 20
        }
        playerData.health += Magnification

        if(playerData.health > playerData.maxHealth){
            playerData.health = playerData.maxHealth
        }
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

    Timer{
        id:accelerateTimer
        interval: 1000
        onTriggered: {
            accelerateText.visible =false
        }
    }

    Timer{
        id:healingTimer
        interval: 1000
        onTriggered: {
            healingText.visible = false
        }
    }

    Timer{
        id:boostTimer
        interval: 1000
        onTriggered: {
            boostText.visible = false
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
        if(event.key === Qt.Key_J){
            player.attacking = false
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

}

