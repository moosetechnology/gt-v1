Class {
	#name : #GTGlamourStackFilter,
	#superclass : #GTDebugger,
	#category : #'GT-GlamourDebugger'
}

{ #category : #'as yet unclassified' }
GTGlamourStackFilter class >> locateBrowserContextFor: aContext [
	
	^ (aContext findContextSuchThat:  [ :ctx | 
		(ctx receiver class inheritsFrom: GLMPresentation)  and: [ ctx selector = #startOn: ] ]) 
]
