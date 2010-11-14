"
self openOn: RPackageOrganizer default
"
Class {
	#name : #GTRBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #building }
GTRBrowser >> buildBrowser [
	"self openOn: RPackageOrganizer default"

	browser := GLMTabulator new.
	browser
		column: #packages;
		column: #classes;
		column: #categories;
		column: #methods.
	(browser transmit)
		to: #packages;
		andShow: [ :composite | self packagesIn: composite ].
	(browser transmit)
		from: #packages;
		to: #classes;
		andShow: [ :composite | self classesIn: composite ].
	(browser transmit)
		from: #classes;
		passivelyFrom: #packages;
		to: #categories;
		andShow: [ :composite | self categoriesIn: composite ].
	(browser transmit)
		from: #classes;
		from: #categories;
		passivelyFrom: #packages;
		to: #methods;
		andShow: [ :composite | self methodsIn: composite ]
]

{ #category : #private }
GTRBrowser >> categoriesIn: a [
	^ (a list)
		title: 'Categories';
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		display: [ :class | class organization categories ]
]

{ #category : #private }
GTRBrowser >> classesIn: composite [
	^ (composite list)
		title: 'Classes';
		display: [ :package | package classes ];
		format: [ :class :package | 
					(package extendsClass: class)
						ifTrue: [ Text string: class name attribute: TextColor gray ]
						ifFalse: [ Text fromString: class name ] ]
]

{ #category : #private }
GTRBrowser >> methodsIn: a [
	a list
		title: 'Instance methods';
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		display: [ :class :category | (class organization listAtCategoryNamed: category) asSortedCollection ];
		format: [:each :class :category :package |
				(package includesSelector: each ofClass: class) 
					ifFalse: [Text string: each asString attribute: TextColor gray]
					ifTrue: [each asString] ].
"	a list 
		title: 'Meta';
		display: [ :package :class | class theMetaClass selectors ];
		format: [:each :package :class |
			(package includesSelector: each ofClass: class class) 
				ifFalse: [Text string: each asString attribute: TextColor gray]
				ifTrue: [each asString] ].	"
	a list
		title: 'Instance methods';
		useExplicitNotNil;
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		when: [ :class :category | class notNil and: [ category isNil ] ];
		display: [ :class :category | class selectors asSortedCollection ];
		format: [:each :class :category :package |
				(package includesSelector: each ofClass: class) 
					ifFalse: [Text string: each asString attribute: TextColor gray]
					ifTrue: [each asString] ].
]

{ #category : #private }
GTRBrowser >> packagesIn: composite [
	composite list 
		title: 'Packages';
		display: [:organizer | organizer packages sort: [:x :y | x name < y name ]];
		format: [:package | package name ]
]
