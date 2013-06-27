Class {
	#name : #GTGlamourStackFilter,
	#superclass : #GTDebugger,
	#category : #'GT-GlamourDebugger'
}

{ #category : #'as yet unclassified' }
GTGlamourStackFilter class >> locateBrowserContextFor: aContext [
	
	^ (aContext findContextSuchThat:  [ :ctx | 
		ctx receiver isGlamourBrowser and: [ ctx selector = #startOn: ] ]) 
]
