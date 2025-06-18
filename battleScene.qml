import QtQuick
import QtQuick.Controls

Item {
    id: battleMap
    anchors.fill: parent
    focus: true

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
    }

    Monsters {
        id:monster
        player:player
        x: Math.random() * (parent.width - width)
        y: Math.random() * (parent.height - height)
    }

    function moveTowardPlayer() {
        if (player && monster) {
            // 计算玩家中心点
            var playerCenterX = player.x + player.width / 2
            var playerCenterY = player.y + player.height / 2

            // 计算怪物中心点
            var monsterCenterX = monster.x + monster.width / 2
            var monsterCenterY = monster.y + monster.height / 2

            // 计算方向向量
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

    Component.onCompleted: {
        player.forceActiveFocus()
    }
}
