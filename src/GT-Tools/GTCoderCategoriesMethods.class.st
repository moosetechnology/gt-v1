Class {
	#name : #GTCoderCategoriesMethods,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #building }
GTCoderCategoriesMethods >> buildBrowser [
	browser := GLMTabulator new.
	browser column: #categories; column: #methods.
	browser transmit
		toOutside: #package;
		fromOutside: #entity;
		transformed: [:packageAndClass | packageAndClass first ].
	browser transmit
		toOutside: #class;
		fromOutside: #entity;
		transformed: [:packageAndClass | packageAndClass last ].
	browser transmit
		to: #categories;
		fromOutside: #class;
		andShow: [:a | self categoriesIn: a ].
	browser transmit 
		to: #methods; 
		fromOutside: #package;
		fromOutside: #class;
		from: #categories; 
		andShow: [ :a | self methodsIn: a ].
	browser transmit 
		toOutside: #selectedCategory;
		from: #categories.
	browser transmit 
		toOutside: #selectedMethod;
		from: #methods.
	^ browser
]

{ #category : #private }
GTCoderCategoriesMethods >> categoriesIn: a [
	a list
		title: 'Categories';
		allowsDeselection;
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		display: [ :class | class organization categories ]
]

{ #category : #private }
GTCoderCategoriesMethods >> methodsIn: a [ 
	a list
		title: 'Methods';
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		display: [ :package :class :category | 
			(class methodDict values select: [:each | each category = category]) asSortedCollection: [:x :y | x selector < y selector ] ];
		format: [:each :package :class |
			((each isDefinedInPackage: package) or: [each isExtensionInPackage: package])
				ifTrue: [each selector asString]
				ifFalse: [Text string: each selector asString attribute: TextColor gray] ].
	a list
		title: 'Methods';
		useExplicitNotNil;
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		when: [ :package :class :category | class notNil and: [ category isNil ] ];
		display: [ :package :class :category | 
			class methodDict values asSortedCollection: [:x :y | x selector < y selector ] ];
		selectionAct: [:list :package :class | 
			(Array with: package with: class with: list selection) inspect  ] on: $/ entitled: 'Inspect';
		format: [:each :package :class |
			((each isDefinedInPackage: package) or: [each isExtensionInPackage: package])
				ifTrue: [each selector asString]
				ifFalse: [Text string: each selector asString attribute: TextColor gray] ].

]
