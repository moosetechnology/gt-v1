Extension { #name : #DebugAction }

{ #category : #'*GT-Debugger' }
DebugAction >> asGlamourAction [

	^ ((GLMGenericAction new) 
			action: [ self execute ]; 
			icon: self icon;
			title: self label;
			yourself)
]
