pragma Singleton
import QtQuick
import RPGtown

QtObject {
    id:monstersData

    property real maxHealth: 100
    property real health: 86
    property real currentHealth: health

    property int baseAttack: 20
    property bool isMonsterDefeated: false
}
