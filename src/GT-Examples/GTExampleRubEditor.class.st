Class {
	#name : #GTExampleRubEditor,
	#superclass : #GTAbstractExampleMenu,
	#category : #'GT-Examples-UI'
}

{ #category : #menus }
GTExampleRubEditor class >> menuFor: aBuilder [
	<contextMenu>
	<RubSmalltalkCodeMenu>
	^ self new
		menuFor: aBuilder
		yourself
]

{ #category : #'as yet unclassified' }
GTExampleRubEditor >> menuFor: aBuilder [
	| selection selectedText selectedString |
	aBuilder model ifNil: [ ^ self ].
	aBuilder model model ifNil: [ ^ self ].
	(selection := aBuilder model selectionInterval) isEmptyOrNil ifTrue: [ ^ self ].
	(selectedText := aBuilder model text copyFrom: selection first to: selection last) isEmptyOrNil ifTrue: [ ^ self ].
	(selectedString := selectedText asString) isEmptyOrNil ifTrue: [ ^ self ].
	
	(lastItem := aBuilder item: 'GT Examples')
		withSeparatorAfter;
		with: [ 
			(lastItem := aBuilder item: #'Browse Examples with subject #' , selectedString)
				action: [ GTExampleNavigation browseExamplesWithSubjectMatching: selectedString ].
			(lastItem := aBuilder item: #'Browse Examples with literal #' , selectedString)
				action: [ GTExampleNavigation browseExamplesLiteralThorough: selectedString asSymbol ]. ]
]
