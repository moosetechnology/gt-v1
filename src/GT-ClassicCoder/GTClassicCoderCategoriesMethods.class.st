"
| browser |
browser := self new browser.
(browser pane port: #entity) value: {RPackageOrganizer default packages last . RPackageOrganizer default packages last classes anyOne}.
browser open
"
Class {
	#name : #GTClassicCoderCategoriesMethods,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-ClassicCoder'
}

{ #category : #building }
GTClassicCoderCategoriesMethods >> buildBrowser [
	browser := GLMTabulator new.
	browser column: #categories; column: #methods.
	browser transmit
		toOutsidePort: #package;
		fromOutsidePort: #entity;
		transformed: [:packageAndClass | packageAndClass first ].
	browser transmit
		toOutsidePort: #class;
		fromOutsidePort: #entity;
		transformed: [:packageAndClass | packageAndClass last ].
	browser transmit
		to: #categories;
		fromOutsidePort: #package;
		fromOutsidePort: #class;
		andShow: [:a | self categoriesIn: a ].
	browser transmit 
		to: #methods; 
		fromOutsidePort: #package;
		fromOutsidePort: #class;
		from: #categories; 
		andShow: [ :a | self methodsIn: a ].
	browser transmit 
		toOutsidePort: #selectedCategory;
		from: #categories.
	browser transmit 
		toOutsidePort: #selectedMethod;
		from: #methods.
	browser transmit to: #categories port: #selection; fromOutsidePort: #focusOnMethod; transformed: [:m | m category ].
	browser transmit to: #methods port: #selection; fromOutsidePort: #focusOnMethod.
	^ browser
]

{ #category : #private }
GTClassicCoderCategoriesMethods >> categoriesIn: a [
	a list
		title: 'Categories';
		allowsDeselection;
		updateOn: SystemAnnouncement from: SystemAnnouncer uniqueInstance;
		display: [ :package :class | class organization categories ];
 		format: [:each :package :class |
			(self isCategory: each of: class definedIn: package)
				ifTrue: [each asString]
				ifFalse: [Text string: each asString attribute: TextColor gray] ]
]

{ #category : #private }
GTClassicCoderCategoriesMethods >> isCategory: aString of: aClass definedIn: aPackage [

	^ (aClass isDefinedInPackage: aPackage) 
		ifTrue: [ (aString beginsWith: '*') not ]
		ifFalse: [ aString = ('*', aPackage name) ]
]

{ #category : #private }
GTClassicCoderCategoriesMethods >> methodsIn: a [ 
	a list
		title: 'Methods';
		updateOn: SystemAnnouncement from: SystemAnnouncer uniqueInstance;
		display: [ :package :class :category | 
			(class methods select: [:each | each category = category]) asSortedCollection: [:x :y | x selector < y selector ] ];
		format: [:each :package :class |
			((each isDefinedInPackage: package) or: [each isExtensionInPackage: package])
				ifTrue: [each selector asString]
				ifFalse: [Text string: each selector asString attribute: TextColor gray] ].
	a list
		title: 'Methods';
		useExplicitNotNil;
		updateOn: SystemAnnouncement from: SystemAnnouncer uniqueInstance;
		when: [ :package :class :category | class notNil and: [ category isNil ] ];
		display: [ :package :class :category | 
			class methods asSortedCollection: [:x :y | x selector < y selector ] ];
		selectionAct: [:list :package :class | 
			(Array with: package with: class with: list selection) inspect  ] on: $i entitled: 'Inspect';
		format: [:each :package :class |
			((each isDefinedInPackage: package) or: [each isExtensionInPackage: package])
				ifTrue: [each selector asString]
				ifFalse: [Text string: each selector asString attribute: TextColor gray] ]
]
