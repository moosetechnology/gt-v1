Extension { #name : #SettingNode }

{ #category : #'*GT-SpotterExtensions-Core' }
SettingNode >> spotterLabel [
	| label |
	label := self settingDeclaration label.
	^ self parentNode isNil
		ifTrue: [ label ]
		ifFalse: [ self parentNode spotterLabel , '/', label ]
		
]

{ #category : #'*GT-SpotterExtensions-Core' }
SettingNode >> spotterPreviewIn: composite [
	<spotterPreview: 0>
	composite custom: 
		self settingDeclaration inputWidget asBrick
]
