Class {
	#name : #GTClassicCoderInstanceAndMetaCategoriesMethods,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools-Coder'
}

{ #category : #'as yet unclassified' }
GTClassicCoderInstanceAndMetaCategoriesMethods >> buildBrowser [
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
			a custom: GTClassicCoderCategoriesMethods new browser ].
	browser transmit 
		fromOutsidePort: #package; 
		from: #outer->#entity transformed: [:class | class ifNotNil: [class theMetaClass] ]; 
		when: [ :package :class | class notNil ];
		transformed: [:package :class | {package . class} ]; 
		to: #meta; andShow: [ :a |
			a title: 'Meta'.
			a custom: GTClassicCoderCategoriesMethods new browser ].
	browser transmit 
		toOutsidePort: #selectedMethod;
		from: #instance port: #selectedMethod.
	browser transmit 
		toOutsidePort: #selectedMethod;
		from: #meta port: #selectedMethod.
	^ browser
]
