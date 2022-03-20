Extension { #name : #WinPlatform }

{ #category : #'*SerialPort' }
WinPlatform >> newSerialPortImplementation [
	
	^ Win32SerialPort new
]
