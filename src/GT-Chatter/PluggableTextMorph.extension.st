Extension { #name : #PluggableTextMorph }

{ #category : #'*GT-Chatter' }
PluggableTextMorph >> chatAboutIt [
	self model chatAboutSelection: self getSelection
]
