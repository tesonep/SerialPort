Extension { #name : #MacOSXPlatform }

{ #category : #'*SerialPort' }
MacOSXPlatform >> newSerialPortImplementation [
	
	^ OSXSerialPort new
]
