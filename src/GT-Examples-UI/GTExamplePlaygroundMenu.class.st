Class {
	#name : #GTExamplePlaygroundMenu,
	#superclass : #GTAbstractExampleMenu,
	#category : #'GT-Examples-UI'
}

{ #category : #menus }
GTExamplePlaygroundMenu class >> menuFor: aPlayground [
	^ self new
		menuFor: aPlayground
		yourself
]

{ #category : #'as yet unclassified' }
GTExamplePlaygroundMenu >> menuFor: aPlayground [
	^ {
		" this is yet too complicated - SIMPLIFY term and behavior for the user 
		
		(GLMGenericAction new) 
			title: 'Browse examples with subject ...';
			action: [ :aPresentation | GTExampleNavigation browseExamplesWithSubjectMatching:  aPresentation selectedText asString ]; 
			category: 'GT Examples';
			yourself.
		"
		(GLMGenericAction new) 
			title: 'Browse examples with literal ...';
			action: [ :aPresentation | GTExampleNavigation browseExamplesLiteralThorough: aPresentation selectedText asString ]; 
			category: 'GT Examples';
			yourself.
	}
]
