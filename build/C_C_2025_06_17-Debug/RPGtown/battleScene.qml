import QtQuick
import QtQuick.Controls

Item {
    id:battleMap
    anchors.fill: parent
    focus: true

    Image {
        id: battleImage
        source: "qrc:/map/battlemap.png"
        anchors.centerIn: parent
        width: sourceSize.width
        height: sourceSize.height
    }

    Player{
        id:player
        focus: true
        x:800
        y:10
    }

    Component.onCompleted: {
        player.forceActiveFocus()
    }

}
