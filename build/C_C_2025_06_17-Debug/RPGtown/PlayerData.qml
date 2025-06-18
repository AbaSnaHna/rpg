pragma Singleton
import QtQuick 2.0
import RPGtown 1.0

QtObject {
    id: playerData

    //角色属性
    property real maxHealth: 100
    property real health: 86
    property real currentHealth: health
    property real maxMana: 500
    property int money: 1000

    property int defense: 10

    property int baseAttack: 20
    property int currentAttack:baseAttack
    property int baseAttackDistance: 500
    property int currentAttackDistance: baseAttackDistance

    property ListModel bag: ListModel{
        ListElement{
            itemId:"knife"
            icon:"qrc:/weapons/knife.png"
            name:"匕首"
            count:1
            type:"buff"
            buffType:"attack"
            value:2
        }

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

        ListElement{
            itemId:"potion"
            icon:"qrc:/weapons/potion.png"
            name:"生命药水"
            count:0
            type:"buff"
            buffType:"healing"
            value:2
        }
    }
}
