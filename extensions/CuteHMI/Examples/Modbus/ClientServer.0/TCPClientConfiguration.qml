import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import CuteHMI.Modbus 2.0

GridLayout {
	columns: 2

	property TCPClient client

	Label {
		Layout.alignment: Qt.AlignRight

		text: qsTr("Host:")
	}

	TextField {
		text: client.host
		onEditingFinished: client.host = text
	}

	Label {
		Layout.alignment: Qt.AlignRight

		text: qsTr("Port:")
	}

	TextField {
		text: client.port
		onEditingFinished: client.port = text
	}

	Label {
		Layout.alignment: Qt.AlignRight

		text: qsTr("Slave address:")
	}

	SpinBox {
		from: 1
		to: 247
		value: client.slaveAddress
		editable: true

		onValueChanged: client.slaveAddress = value
	}
}

//(c)MP: Copyright © 2019, Michal Policht <michpolicht@gmail.com>. All rights reserved.
//(c)MP: This file is a part of CuteHMI.
//(c)MP: CuteHMI is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
//(c)MP: CuteHMI is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more details.
//(c)MP: You should have received a copy of the GNU Lesser General Public License along with CuteHMI.  If not, see <https://www.gnu.org/licenses/>.