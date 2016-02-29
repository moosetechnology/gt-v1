Extension { #name : #GLMBrowserClosing }

{ #category : #'*GT-Debugger-EventRecorder' }
GLMBrowserClosing >> asRecorderEvent [

	^ GLMRecorderBrowserClosingEvent fromAnnouncement: self
]
