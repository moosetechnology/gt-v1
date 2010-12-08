Class {
	#name : #GTCoderInstanceAndMetaCategoriesMethods,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools-Coder'
}

{ #category : #'as yet unclassified' }
GTCoderInstanceAndMetaCategoriesMethods >> buildBrowser [
	"
	| browser |
	browser := self new browser.
	(browser pane port: #package) value: RPackageOrganizer default packages first.
	(browser pane port: #entity) value: RPackageOrganizer default packages first classes anyOne.
	browser open.
	browser inspect"
	browser := GLMStacker new.
	browser aPane: #instance; aPane: #meta.
	browser transmit 
		from: #outer->#package; 
		from: #outer->#entity; 
		when: [ :package :class | class notNil ];
		transformed: [:package :class | {package . class} ]; 
		to: #instance; 
		andShow: [ :a |
			a title: 'Instance'.
			a custom: GTCoderCategoriesMethods new browser ].
	browser transmit 
		from: #outer->#package; 
		from: #outer->#entity transformed: [:class | class ifNotNil: [class theMetaClass] ]; 
		when: [ :package :class | class notNil ];
		transformed: [:package :class | {package . class} ]; 
		to: #meta; andShow: [ :a |
			a title: 'Meta'.
			a custom: GTCoderCategoriesMethods new browser ].
	^ browser
]
