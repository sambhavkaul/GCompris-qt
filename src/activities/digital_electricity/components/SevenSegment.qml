/* GCompris - SevenSegment.qml
 *
 * Copyright (C) 2016 Pulkit Gupta <pulkitnsit@gmail.com>
 *
 * Authors:
 *   Bruno Coudoin <bruno.coudoin@gcompris.net> (GTK+ version)
 *   Pulkit Gupta <pulkitnsit@gmail.com> (Qt Quick port)
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.3
import "../digital_electricity.js" as Activity

import GCompris 1.0

ElectricalComponent {
    id: sevenSegmentDisplay
    imgWidth: 0.18
    imgHeight: 0.4
    imgSrc: "sevenSegmentDisplay.svgz"
    toolTipTxt: qsTr("7 Segment Display")
    terminalSize: 0.116
    noOfInputs: 7
    noOfOutputs: 0
    property variant inputTerminalPosY: [0.058,0.195,0.337,0.484,0.636,0.791,0.942]
    property variant redBars: ["sevenSegmentDisplayA.svgz","sevenSegmentDisplayB.svgz","sevenSegmentDisplayC.svgz",
                               "sevenSegmentDisplayD.svgz","sevenSegmentDisplayE.svgz","sevenSegmentDisplayF.svgz",
                               "sevenSegmentDisplayG.svgz"]

    information: qsTr("7 segment display takes 7 binary inputs in its input terminals. The display " +
                      "consists of 7 segments and each segment gets lighted according to the input. " +
                      "By generating different combination of binary inputs, the display can be used to " +
                      "display various different symbols. The diagram is:")

    property string infoImageSrc: "7SegmentDisplay.svg"

    property alias inputTerminals: inputTerminals

    Repeater {
        id: inputTerminals
        model: 7
        delegate: inputTerminal
        Component {
            id: inputTerminal
            TerminalPoint {
                posX: 0.06
                posY: inputTerminalPosY[index]
                type: "In"
            }
        }
    }

    function updateOutput(wireVisited) {
        for(var i = 0 ; i < noOfInputs ; ++i) {
            if(inputTerminals.itemAt(i).value == 1)
                outputBar.itemAt(i).visible = true;
            else
                outputBar.itemAt(i).visible = false;
        }
    }

    Repeater {
        id: outputBar
        model: 7
        delegate: outputBarImages
        Component {
            id: outputBarImages
            Image {
                source: Activity.url + redBars[index]
                visible: false //code[0] == 1
                anchors.centerIn: parent
                height: parent.height
                width: parent.width
                fillMode: Image.PreserveAspectFit
                mipmap: true
                antialiasing: true
            }
        }
    }
}
