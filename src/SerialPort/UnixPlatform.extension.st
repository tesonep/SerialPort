Extension { #name : #UnixPlatform }

{ #category : #'*SerialPort' }
UnixPlatform >> newSerialPortImplementation [
	
	^ LinuxSerialPort new
]
