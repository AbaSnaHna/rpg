pragma Singleton
import QtQuick

QtObject{
    id:playerData

    property var activeBuffs: ({})

    //角色基础属性
    property real maxHealth: 100
    property real health: maxHealth
    property real maxMana: 500
    property int money:1000

    property int defense: 10

    property ListModel bag: ListModel{
        ListElement{icon:"qrc:/weapons/knife.png"; name:"匕首";count:1}
        ListElement{
            itemId:"wings"
            icon:"qrc:/weapons/wings.png"
            name: "伊卡洛斯的羽翼"
            count:2
            type:"buff"
            buffType:"speed"
            value:2
            duration:10000
        }
    }

}
