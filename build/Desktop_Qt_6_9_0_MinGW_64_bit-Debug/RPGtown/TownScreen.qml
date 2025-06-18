import QtQuick
import QtQuick.Controls
import QtMultimedia

Item {
    id: townScreen
    anchors.fill: parent
    focus: true

    // 地图背景
    Image {
        id: map
        source: "qrc:/map/Map003.png"
        smooth: false
        width: sourceSize.width
        height: sourceSize.height
        x:0
        y:0
    }

    Player{
        id:player
    }

    // 状态保存/加载
    function savePlayerState() {
        mainWindow.playerState = {
            x: player.x + map.x,
            y: player.y + map.y,
            direction: player.direction,
            inventory: mainWindow.playerState.inventory
        }
    }

    function loadPlayerState(spawnPoint) {
        if(spawnPoint) {
            player.x = spawnPoint.x - map.x
            player.y = spawnPoint.y - map.y
        } else {
            player.x = mainWindow.playerState.x - map.x
            player.y = mainWindow.playerState.y - map.y
        }
        player.direction = mainWindow.playerState.direction || "down"
    }

    MediaPlayer{
        id:backgroudPlayer
        source: "qrc:/BGM/The First Town.mp3"
        audioOutput: AudioOutput{
            volume: 0.8
        }

        loops: MediaPlayer.Infinite
    }

    Component.onCompleted: {
        loadPlayerState()
        player.forceActiveFocus()
        backgroudPlayer.play()
    }

    Component.onDestruction: {
        backgroudPlayer.stop()
    }
}
