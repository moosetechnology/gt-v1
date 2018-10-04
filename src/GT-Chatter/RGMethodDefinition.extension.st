Extension { #name : #RGMethodDefinition }

{ #category : #'*GT-Chatter' }
RGMethodDefinition >> gtInspectorActionChatAboutIt [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ 
			| ring message receiver |
			ring := self copy.
			ring 
				sourceCode: self sourceCode;
				protocol: self protocol;
				stamp: self stamp.
			message := GTCSelectionInMethodMessage new.
			message 
				ring: ring.
			receiver := GTChatter me selectRecipient.
			message to: receiver.
			receiver ifNotNil: [ GTChatter me send: message ] ];
"		icon: MooseIcons mooseIcon asGrayScaleWithAlpha;
"		title: 'Chat about it'
]
