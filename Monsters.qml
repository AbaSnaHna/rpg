import QtQuick

Item {
    id:monster
    width: 48
    height: 48

    property int speed: 2
    property Item player:null
    property string direction: "down"
    property bool moving: false
    property int currentFrame: 0
    property int  frameCount: 3

    AnimatedSprite{
        id:monsterSprite
        anchors.fill: parent
        frameCount: 12
        frameWidth: 48
        frameHeight: 48
        frameRate: 8
        source: "qrc:/monsters/monsters1.png"
        interpolate: false

        frameX: {
            return currentFrame * frameWidth
        }

        frameY: {
            switch(monster.direction){
                case "down": return 0
                case "left": return frameHeight
                case "right": return frameHeight * 2
                case "up": return frameHeight * 3
                default: return 0
            }
        }
        running: monster.moving
    }

    Timer{
        interval: 1000/monsterSprite.frameRate

        running: monster.moving
        repeat: true
        onTriggered: {
            currentFrame = (currentFrame +1) % frameCount
        }
    }

    onDirectionChanged: {
        currentFrame = 0
    }
}
