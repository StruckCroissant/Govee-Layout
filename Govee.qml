Item {
    anchors.fill: parent

    Column{
        width: parent.width
        height: parent.height
        spacing: 10

		Rectangle{
			id: scanningItem
			height: 50
			width: childrenRect.width + 15
			visible: service.controllers.length === 0
			color: theme.background3
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
					font.family: "Montserrat"
				}
				Text{
					color: theme.secondarytextcolor
					text: "This may take several minutes..." 
					font.pixelSize: 14
					font.family: "Montserrat"
				}
			}
		}

        Rectangle {
            width: 300
            height: 45
            color: Qt.lighter(theme.background2, 1.3)
            radius: 5       

            Rectangle {
				    width: 290
				    height: 35
				    radius: 5
				    border.color: "#1c1c1c"
				    border.width: 1
                    

                    
                    anchors.centerIn: parent
                    
                    
				    
				    color: Qt.lighter(theme.background1, 1.3)

			        TextField {
			        		width: parent.width

			        		id: discoverIP
			        		color: theme.secondarytextcolor
			        		font.family: "Poppins"
			        		font.pixelSize: 15
			        		verticalAlignment: Text.AlignHCenter
			        		placeholderText: "Forced Dicovery IP Address"

			        		validator: RegularExpressionValidator {
			        			regularExpression:  /^((?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){0,3}(?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$/
			        		}

                            onEditingFinished: {
			    			    discovery.checkCachedDevice(discoverIP.text);
			    		    }

			        		background: Item {
			        			width: parent.width
			        			height: parent.height

			        			Rectangle {
			        				color: "transparent"
			        				height: 1
			        				width: parent.width
			        				anchors.bottom: parent.bottom
			        			}
			        		}
			        }
				}
        }
        
    
        Repeater{
            model: service.controllers          

            delegate: Item {
                id: root
                width: 300
                height: content.height
                property var device: model.modelData.obj

                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: Qt.lighter(theme.background2, 1.3)
                    radius: 5
                    
                    Image {
                        width: 42
                        height: 42

                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter

                        source: "qrc:/icons/Resources/Icons/Icons_Onboarding_Icon.svg"
                    }
                }



                Column{
                    id: content
                    width: parent.width
                    padding: 15
                    spacing: 5

                    Row{
                        width: parent.width
                        height: childrenRect.height

                        Column{
                            id: leftCol
                            width: 260
                            height: childrenRect.height
                            spacing: 5

                            Text{
                                color: theme.primarytextcolor
                                text: device.name
                                font.pixelSize: 16
                                font.family: "Poppins"
                                font.weight: Font.Bold
                            }

                            Row{
                                spacing: 5
                                Text{
                                    color: theme.secondarytextcolor
                                    text: "IP Address: " + (device.ip != "" ? device.ip : "Unknown")
                                }
                            }

                            Row{
                                visible: false
                                spacing: 5
                                Text{
                                    color: theme.secondarytextcolor
                                    text: "Id: " + device.id
                                }

                                Text{
                                    color: theme.secondarytextcolor
                                    text: "|"
                                }

                                Text{
                                    color: theme.secondarytextcolor
                                    text: "SKU: "+ device.sku
                                }  
                            }
                                                            
                            Text{
                                visible: false
                                color: theme.secondarytextcolor
                                text: "Wifi Version: "+ device.wifiVersionSoft
                            }  

                            Text{
                                visible: false
                                color: theme.secondarytextcolor
                                text: `Supports DreamView Protocol: ${device.supportDreamView  ? "True" : "False"}`
                            }

                            Text{
                                visible: false
                                color: theme.secondarytextcolor
                                text: `Supports Razer Protocol: ${device.supportRazer ? "True" : "False"}`
                            }

                        }

                    }
                }
            }  
        }
    }
}