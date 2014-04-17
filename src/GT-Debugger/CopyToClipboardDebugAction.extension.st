Extension { #name : #CopyToClipboardDebugAction }

{ #category : #'*GT-Debugger-Actions' }
CopyToClipboardDebugAction class >> gtActionFor: aDebugger [
	<gtDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			order: 35
]
