import QtQuick
import QtQuick.Controls
import QtMultimedia

Item {
    id: weaponShop
    focus: true
    anchors.centerIn: parent

    property int selectedItem: -1

    property var playerData: PlayerData
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
        onClicked: {
            mainWindow.changeScene("TownScreen.qml", {x: 1053, y: 600})
}
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

    property var dialogues: [
        {text:"欢迎来到利兹武器店！\n我是老板利兹\n想看看什么商品吗？", islast:false},
        {text:"这是我们的最新商品！\n您需要什么类型的武器？", islast:false},
        {text:"你看来很强啊！\n其实我这里有个工会的委托", islast:false},
        {text:"是小镇南边的魔物问题\n不知道为什么，最近魔物们很活跃" , islast:false},
        {text:"你愿意帮我们个忙吗\n就解决一部分就好，一部分", islast:false},
        {text:"当然，赏金肯定是少不了的", islast:false},
        {text:"还是你只是来买东西的", islast:true}
    ]

    property int currentDialogueIndex: 0

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

        MouseArea{
            anchors.fill: parent
            onClicked: {
                updateDialogue();
            }
        }

        Column{
            anchors.fill: parent
            padding: 10

            Text {
                id:dialogueText
                text: dialogues[currentDialogueIndex].text
                color: "white"
                font.pixelSize: 16
                wrapMode: Text.WordWrap
                width:parent.width
            }

            Row{
                id:buttonRow
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter
                visible: dialogues[currentDialogueIndex].islast

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

                Button{
                    text:"接受委托"
                    onClicked: {
                        mainWindow.changeScene("battleScene.qml", {x:100, y:100})
                    }
                }
            }
        }
    }

    function updateDialogue(){
        currentDialogueIndex++
        if(currentDialogueIndex < dialogues.length){
            dialogueText.text = dialogues[currentDialogueIndex].text
            buttonRow.visible = dialogues[currentDialogueIndex].islast
        }else{
            dialogueBox.visible = false
            currentDialogueIndex = 0
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
            buffType:"speed"
            value:2
        }

        ListElement{
            itemId:"potion"
            icon:"qrc:/weapons/potion.png"
            name:"生命药水"
            cost:50
            stock:100
            type:"buff"
            buffType:"healing"
            value:2
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
                            buyButton.enabled = (playerData.money >= item.cost && item.stock > 0)
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
            onClicked: shopWindow.buyItem(selectedItem, playerData)
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

        function buyItem(itemIndex, playerData){
            var item = goods.get(itemIndex)

            if(item.stock <= 0){
                console.log("商品售罄")
                return false
            }
            if(playerData.money < item.cost){
                showReminder();
                console.log("金币不足")
                return false
            }

            playerData.money -= item.cost
            goods.setProperty(itemIndex, "stock", item.stock - 1)

            addToPlayerBag(playerData, item)
            return true
        }

        function addToPlayerBag(playerData, item){
            for (var i = 0; i < playerData.bag.count; i++) {
                if (playerData.bag.get(i).itemId === item.itemId) {
                    playerData.bag.setProperty(i, "count", playerData.bag.get(i).count + 1)
                    return
                }
            }

            playerData.bag.append({
                                  itemId:item.itemId,
                                  name:item.name,
                                  icon:item.icon,
                                  count:1,
                                  type:item.type,
                                  buffType:item.buffType
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
