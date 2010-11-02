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
		to: #methods;
		andShow: [ :composite | self methodsIn: composite ]
]

{ #category : #private }
GTRBrowser >> categoriesIn: a [
	^ (a list)
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		display: [ :class | class organization categories ]
]

{ #category : #private }
GTRBrowser >> classesIn: composite [
	^ (composite list)
		display: [ :package | package classes ];
		format: [ :class :package | 
					(package extendsClass: class)
						ifTrue: [ Text string: class name attribute: TextColor gray ]
						ifFalse: [ Text fromString: class name ] ]
]

{ #category : #private }
GTRBrowser >> methodsIn: a [
	(a list)
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		display: [ :class :category | (class organization listAtCategoryNamed: category) asSortedCollection ].
	^ (a list)
		useExplicitNotNil;
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		when: [ :class :category | class notNil and: [ category isNil ] ];
		display: [ :class :category | class selectors asSortedCollection ]
]

{ #category : #private }
GTRBrowser >> packagesIn: composite [
	composite list 
			display: [:organizer | organizer packages sort: [:x :y | x name < y name ]];
			format: [:package | package name ]
]
