Class {
	#name : #GTCoderInstanceAndMetaCategoriesMethods,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools-Coder'
}

{ #category : #'as yet unclassified' }
GTCoderInstanceAndMetaCategoriesMethods >> buildBrowser [
	browser := GLMStacker new.
	browser aPane: #instance; aPane: #meta.
	browser transmit 
		from: #outer->#package; 
		from: #outer->#class; 
		to: #instance; andShow: [ :a |
			a title: 'Instance'.
			a custom: GTCoderCategoriesMethods new browser ].
	browser transmit 
		from: #outer->#package; 
		from: #outer->#class transformed: [:class | class "theMetaClass" ]; 
		when: [ :package :class | class notNil ];
		to: #meta; andShow: [ :a |
			a title: 'Meta'.
			a custom: GTCoderCategoriesMethods new browser ].
	^ browser
]
