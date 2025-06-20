import QtQuick
import QtQuick.Controls
import QtMultimedia

Item {
    id: weaponShop
    focus: true
    anchors.centerIn: parent

    property int selectedItem: -1
    // 背景
    Image {
        id:map
        source: "qrc:/map/Map004.png"
        anchors.centerIn: parent
        smooth: false
        width: sourceSize.width
        height: sourceSize.height

        property int mapWidth: width
        property int mapHeight: height
    }

    Player{
        focus: true
        id:player
        width: 64
        height: 64
        x:800
        y:760
    }

    // 返回按钮
    Button {
        text: "离开商店"
        anchors { bottom: parent.bottom; right: parent.right; margins: 100 }
        onClicked: mainWindow.changeScene("TownScreen.qml", {x: 1053, y: 600})

        background: Rectangle {
            color: "#8B4513"
            radius: 5
            border.color: "#5D2906"
            border.width: 2
        }
    }

    function savePlayerState() {
        mainWindow.playerState.direction = "down"
    }

    function loadPlayerState() {
        player.direction = "up"
    }

    MediaPlayer{
        id:backgroudPlayer
        source: "qrc:/BGM/At Nightfall.mp3"
        audioOutput: AudioOutput{
            volume: 0.8
        }
        loops: MediaPlayer.Infinite
    }

    //老板
    Item {
        id: keeper
        width: 64
        height: 64

        Image {
            id: shopkeeper
            source: "qrc:/Chara/NPC/orgirl1.png"
            x:805
            y:400
        }
    }

    Rectangle{
        id:dialogueBox
        visible: false
        width: 300
        height: 123
        anchors.centerIn: parent
        color:"#AA333333"
        radius: 10
        border.color: "gold"

        Column{
            anchors.fill: parent
            padding: 10

            Text {
                id:dialogueText
                text: "欢迎来到利兹武器店！\n我是老板利兹\n想看看什么商品吗？"
                color: "white"
                font.pixelSize: 16
                wrapMode: Text.WordWrap
                width:parent.width
            }

            Row{
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter

                Button{
                    text:"购买物品"
                    onClicked: {
                        openShop();
                        dialogueBox.visible = false
                    }
                }

                Button{
                    text: "离开"
                    onClicked: {
                        dialogueBox.visible = false
                        player.forceActiveFocus()
                    }
                }

            }
        }
    }

    property ListModel goods: ListModel{
        ListElement{
            itemId:"wings"
            icon:"qrc:/weapons/wings.png"
            name:"伊卡洛斯的羽翼"
            cost:200
            stock:20
            type:"buff"
        }
    }

    Rectangle{
        id:shopWindow
        visible: false
        width: 500
        height: 400
        anchors.centerIn: parent
        color:"#DD222222"

        GridView{
            id:itemsGrid
            anchors.fill: parent
            cellHeight: 64
            cellWidth: 64

            topMargin: 10
            leftMargin: 10
            model: weaponShop.goods
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
                        text:cost
                        color: "gold"
                        font.pixelSize: 10
                        horizontalAlignment: Text.AlignHCenter
                    }
}
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        selectedItem = index
                        var item = goods.get(index)
                            buyButton.enabled = (player.money >= item.cost && item.stock > 0)
                    }
                }
            }
        }


        Button{
            id:buyButton
            text:"购买"
            anchors{
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                margins: 20
            }
            enabled: false
            onClicked: shopWindow.buyItem(selectedItem, player)
        }

        Button{
            text: "关闭商店"
            onClicked: {
                shopWindow.visible = false
                player.forceActiveFocus()
            }
        }

        Rectangle{
            id:reminder
             anchors.centerIn: parent
             width: 200
             height: 60
             color: "#AA0000"
             radius: 10
             visible: false
             z:100

             Text {
                 anchors.centerIn: parent
                 text: "金币不足"
                 color: "white"
                 font.bold: true
                 font.pixelSize: 16
             }
        }

        Timer{
            id:reminderTimer
            interval: 1500
            onTriggered: reminder.visible = false
        }

        function showReminder(){
            reminder.visible = true
            reminderTimer.start()
        }

        function buyItem(itemIndex, player){
            var item = goods.get(itemIndex)

            if(item.stock <= 0){
                console.log("商品售罄")
                return false
            }
            if(player.money < item.cost){
                showReminder();
                console.log("金币不足")
                return false
            }

            player.money -= item.cost
            goods.setProperty(itemIndex, "stock", item.stock - 1)

            addToPlayerBag(player, item)
            return true
        }

        function addToPlayerBag(player, item){
            for (var i = 0; i < player.bag.count; i++) {
                if (player.bag.get(i).itemId === item.itemId) {
                    player.bag.setProperty(i, "count", player.bag.get(i).count + 1)
                    return
                }
            }

            player.bag.append({
                                  itemId:item.itemId,
                                  name:item.name,
                                  icon:item.icon,
                                  count:1,
                                  type:item.type,
                              })
        }
    }

    property bool isPlayerNearBy: false

    Timer{
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            isPlayerNearBy = calculateDistance(player, keeper) < 100
        }
    }


    function openShop(){
        shopWindow.visible = true
    }

    function showDialogue(){
        dialogueBox.visible = true
    }

    function calculateDistance(player, keeper){

        var x1 = player.x + player.width/2
        var y1 = player.y + player.height/2
        var x2 = keeper.x + keeper.width/2
        var y2 = keeper.y + keeper.height/2

        return Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2))
    }

    Component.onCompleted: {
        player.forceActiveFocus()
        backgroudPlayer.play()
    }

    Component.onDestruction: {
        backgroudPlayer.stop()
    }
}
