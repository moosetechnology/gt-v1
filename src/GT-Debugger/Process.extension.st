Extension { #name : #Process }

{ #category : #'*gt-debugger' }
Process >> stepUntil: aPredicate from: aContext [
	"Resume self until the top context safisfy the given condition."

	| ctxt  |
	
	ctxt := aContext.
	[ 
		ctxt notNil and: [aPredicate matches: ctxt]
	] whileFalse: [
		ctxt := self step: ctxt.
	].
	^ ctxt
]
