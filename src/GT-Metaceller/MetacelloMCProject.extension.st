Extension { #name : #MetacelloMCProject }

{ #category : #'*gt-metaceller' }
MetacelloMCProject class >> new [
	" here we put in a hook, so we can create our own projects "
	| retVal |
	retVal := GTMetacelloProject template.
	retVal configuration: retVal.
	^retVal
]
