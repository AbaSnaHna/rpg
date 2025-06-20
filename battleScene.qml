import QtQuick
import QtQuick.Controls
import QtMultimedia

Item {
    id: battleMap
    anchors.fill: parent
    focus: true

    property var playerData: PlayerData
    property var monsterData: MonsterData

    Image {
        id: battleImage
        source: "qrc:/map/battlemap.png"
        anchors.centerIn: parent
        width: sourceSize.width
        height: sourceSize.height
}

    Player {
        id: player
        focus: true
        x: 800
        y: 10

        Rectangle {
            id:healthBar

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
    }

    Monsters{
        id:monster
        player:player
        x: Math.random() * (parent.width - width)
        y: Math.random() * (parent.height - height)

        Rectangle {
            id:monsterHealthBar
            z:1
            width: 50
            height: 8
            radius: 4
            color: "#442222"

            Rectangle {
                width: (parent.width * monsterData.currentHealth / monsterData.maxHealth)
                height: parent.height
                radius: parent.radius
                color: "#FF5555"
                Behavior on width {
                    NumberAnimation { duration: 300 }
                }
            }

            Text {
                id: monsterHealthText
                anchors.centerIn: parent
                text:`${monsterData.currentHealth}/${monsterData.maxHealth}`
                color: {
                    if(monsterData.currentHealth < monsterData.maxHealth * 0.3) "red"
                    else if(monsterData.currentHealth < monsterData.maxHealth * 0.6) "orange"
                    else "white"
                }
                font.pixelSize: 10

                Behavior on text {
                    NumberAnimation{ duration:300}
                }
            }
        }

    }

    Rectangle{
        id:hintBox
        anchors.horizontalCenter: parent.horizontalCenter
        y:parent.height * 0.25
        width: sceneName.width + 40
        height: sceneName.height + 20
        radius: 10
        color:"#AAFFA500"
        border.color: "white"
        border.width: 2
        opacity: 0
        scale: 0.8

        Text {
            id: sceneName
            anchors.centerIn: parent
            text: "虎溪"
            color:"white"
            font{
                family: "Hiragino Sans GB"
                pixelSize: 100
                bold: true
                italic: true
            }
        }

        ParallelAnimation{
            id:enterAnim
            running: true
            NumberAnimation{target:hintBox; property: "opacity"; to:1; duration: 800}
            NumberAnimation{target:hintBox; property: "scale"; to:1; duration: 800;
                easing.type: Easing.OutBack}
        }

        Timer{
            interval: 2500
            running: true
            onTriggered: exitAnim.start()
        }

        ParallelAnimation{
            id:exitAnim
            running: true
            NumberAnimation{target:hintBox; property: "opacity"; to:0; duration: 800}
            NumberAnimation{target:hintBox; property: "scale"; to:0.8; duration: 800;
                easing.type: Easing.OutBack}
        }
    }

    function moveTowardPlayer() {
        if (player && monster) {
            var playerCenterX = player.x + player.width / 2
            var playerCenterY = player.y + player.height / 2

            var monsterCenterX = monster.x + monster.width / 2
            var monsterCenterY = monster.y + monster.height / 2

            var dx = playerCenterX - monsterCenterX
            var dy = playerCenterY - monsterCenterY
            var distance = Math.sqrt(dx * dx + dy * dy)

            if (distance > 0) {
                var stepX = dx / distance * monster.speed
                var stepY = dy / distance * monster.speed

                monster.x += stepX
                monster.y += stepY

                if (Math.abs(dx) > Math.abs(dy)) {
                    monster.direction = dx > 0 ? "right" : "left"
                } else {
                    monster.direction = dy > 0 ? "down" : "up"
                }

                monster.moving = true
            } else {
                monster.moving = false
            }
        }
    }

    Timer{
        interval: 16
        running: true
        repeat: true
        onTriggered: moveTowardPlayer()
    }

    property var transitionAreas: [
        {
            id: "townScene",
            x: 200,  y: 500,
            width: 100, height: 100,
            targetScene: "TownScreen.qml",
            playerSpawn: { x: 870, y: 960 }
        }
    ]

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: checkAreaTransition()
    }

    function checkAreaTransition() {
        if(!player.moving) return

        var playerLeft = player.x
        var playerRight = player.x + player.width
        var playerTop = player.y
        var playerBottom = player.y + player.height

        for(var i = 0; i < transitionAreas.length; i++) {
            var area = transitionAreas[i]

            var areaLeft = area.x
            var areaRight = areaLeft + area.width
            var areaTop = area.y
            var areaBottom = areaTop + area.height

            if(playerRight > areaLeft &&
               playerLeft < areaRight &&
               playerBottom > areaTop &&
               playerTop < areaBottom) {
                mainWindow.changeScene(area.targetScene, area.playerSpawn)
                break
            }
        }
    }


    function monsterDamage(){
        var playerLeft = player.x - playerData.currentAttackDistance
        var playerRight = player.x + player.width + playerData.currentAttackDistance
        var playerTop = player.y
        var playerBottom = player.y +  player.height

        var monsterLeft = monster.x
        var monsterRight = monster.x + monster.width
        var monsterTop = monster.y
        var monsterBottom = monster.y + monster.height

        if(playerRight > monsterLeft &&
                playerLeft < monsterRight &&
                playerBottom > monsterTop &&
                playerTop < monsterBottom){
            attackPlayer.stop()
            attackPlayer.play()

            if(!monster.isInvincible){
                monsterData.currentHealth -= playerData.currentAttack
                monster.isInvincible = true
                monsterInvincibleTimer.start()
            }

            if(!player.isInvincible &&
                    player.x < monster.x + monster.width &&
                    player.x + player.width > monster.x &&
                    player.y < monster.y + monster.height &&
                    player.y + player.height > monster.y){

               playerData.currentHealth -= monsterData.baseAttack
               player.isInvincible = true
               playerInvincibleTimer.start()
           }
        }

        if(monsterData.currentHealth <= 0){
            monsterDisapear()
            backgroundPlayer.stop()
            backgroundPlayer2.play()
        }
    }


    function monsterDisapear(){
        monster.destroy()
        monsterData.isMonsterDefeated = true
    }

    Timer{
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            monsterDamage()
        }
    }

    Timer{
        id:playerInvincibleTimer
        interval: 1000
        onTriggered: {
            player.isInvincible = false
        }
    }

    Timer{
        id:monsterInvincibleTimer
        interval: 500
        onTriggered: {
            monster.isInvincible = false
        }
    }

    MediaPlayer{
        id:attackPlayer
        source: "qrc:/BGM/Attack2.wav"
        audioOutput: AudioOutput {
            volume: 0.8
        }
        loops:1
    }

    MediaPlayer{
        id:backgroundPlayer
        source: "qrc:/BGM/light your sword.mp3"
        audioOutput: AudioOutput{
            volume: 0.5
        }
        loops:MediaPlayer.Infinite
    }

    MediaPlayer{
        id:backgroundPlayer2
        source: "qrc:/BGM/At Nightfall.mp3"
        audioOutput: AudioOutput{
            volume: 0.5
        }
        loops:MediaPlayer.Infinite
    }

    Component.onCompleted: {
        backgroundPlayer.play()

        player.forceActiveFocus()
    }

    Component.onDestruction: {
        backgroundPlayer2.stop()
    }
}
