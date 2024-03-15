import QtQuick.Layouts

Item {
    anchors.fill: parent

    Column{
        width: parent.width
        height: parent.height
        spacing: 10

		Rectangle{
			id: scanningItem
			height: 50
			width: 350
			visible: service.controllers.length === 0
			color: theme.background2
			radius: theme.radius

			BusyIndicator {
				id: scanningIndicator
				height: 30
				anchors.verticalCenter: parent.verticalCenter
				width: parent.height
				Material.accent: "#88FFFFFF"
				running: scanningItem.visible
			}  

			Column{
				width: childrenRect.width
				anchors.left: scanningIndicator.right
				anchors.verticalCenter: parent.verticalCenter

				Text{
					color: theme.secondarytextcolor
					text: "Searching network for Govee Devices..." 
					font.pixelSize: 14
					font.family: theme.primaryfont
				}
				Text{
					color: theme.secondarytextcolor
					text: "This may take several minutes..." 
					font.pixelSize: 14
					font.family: theme.primaryfont
				}

			}
		}    
    
         Pane {
                width: 352
                height: 136
                padding: 8

                background: Rectangle {
                    color: theme.background2
                    radius: 8
                }

                ColumnLayout {
                    spacing: 4
                    anchors.fill: parent

                    Text{
				        color: "White"
				        text: "Manually Specify IP Address" 
				        font.family: theme.primaryfont
                        font.weight: Font.Bold
                        font.pixelSize: 16
                    }

                    TextField {

                        Layout.preferredWidth: 334
			        	id: discoverIP
			        	color: theme.secondarytextcolor
			        	font.family: theme.secondaryfont

			        	validator: RegularExpressionValidator {
			        	    regularExpression:  /^((?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){0,3}(?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$/
			        	}
                        
                        onEditingFinished: {
			    			discovery.checkCachedDevice(discoverIP.text);
			    		}

                        background: Rectangle {
                            color: theme.background3
                            radius: 4
                        }
			        }

                    SButton{
                        Layout.alignment: Qt.AlignRight
                        color: hovered ? Qt.darker("#531B1B", 1.5) : "#531B1B"
                        label.font.pixelSize: 16
                        label.text: "Clear IP Cache"

                        onClicked : {
                            discovery.purgeIPCache();
                        }
                    }

                }
            }

        Repeater{
            model: service.controllers          

            delegate: Pane {
            id: root
            width: 352 // set Width
            height: contentHeight + padding * 2// dynamic height based on content
            padding: 12

            background: Rectangle {
                color: theme.background2
                radius: 8
            }
            property var device: model.modelData.obj

            property bool isExpanded: false // Use bool, int, real, etc over var for better performance

            ColumnLayout{
                width: parent.width
                spacing: 4

                Item{
                    width: parent.width
                    height: 20

                    Text{
                        id: deviceName
                        color: theme.primarytextcolor
                        text: root.device.name
                        font.pixelSize: 16
                        font.family: theme.primaryfont
                        font.weight: Font.Bold
                        verticalAlignment: Text.AlignVCenter
                    }

                    SIconButton{
                        id: expandButton
                        width: 24
                        height: 24
                        iconSize: height
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter

                        icon.source: "qrc:/icons/Resources/Icons/Icons_Onboarding_Icon.svg"

                      onClicked: {
                          root.isExpanded = !root.isExpanded

                       }
                    }
                }

                Text{
                    color: theme.secondarytextcolor
                    text: "IP Address: " + root.device.ip ?? "Unknown"
                }


                Text{
                    color: theme.secondarytextcolor
                    text: `Id: ${root.device.id} | SKU: ${root.device.sku}`
                }

                Text{
                    visible: root.isExpanded
                    color: theme.secondarytextcolor
                    text: "Wifi Version: "+ root.device.wifiVersionSoft
                }

                Text{
                    visible: root.isExpanded
                    color: theme.secondarytextcolor
                    text: `Supports DreamView Protocol: ${root.device.supportDreamView  ? "True" : "False"}`
                }

                Text{
                    visible: root.isExpanded
                    color: theme.secondarytextcolor
                    text: `Supports Razer Protocol: ${root.device.supportRazer ? "True" : "False"}`
                }
            }
            }
        }
    }
}