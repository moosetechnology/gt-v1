Extension { #name : #DebugAction }

{ #category : #'*GT-Debugger' }
DebugAction >> asGlamourAction [

	^ ((GLMGenericAction new) 
			action: [ self execute ]; 
			icon: self icon;
			title: self label;
			help: self help;
			showTitle;
			shortcut: (self keyText ifNotNil: [:aString | aString at: 1]);
			category: self category;
			yourself)
]

{ #category : #'*GT-Debugger' }
DebugAction >> specModel [
	"This method has a hack to work both in Pharo 6.1 and Pharo 7, as models in Spec were renamed."
	^ Smalltalk globals 
		at: #GTDebugActionButton 
		ifPresent: [ #GTDebugActionButton ] 
		ifAbsent: [ #SpecDebugActionButton ]
]
