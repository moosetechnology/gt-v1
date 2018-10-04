Class {
	#name : #GTCodeFinder,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools-Prototypes'
}

{ #category : #building }
GTCodeFinder >> buildBrowser [ 
	"self openOn: Smalltalk"
	browser := GLMFinder new.
	browser show: [:a | 
		a title: [ :object | object printString ].
		self smalltalkIn: a.
		].
	^ browser 
]

{ #category : #building }
GTCodeFinder >> smalltalkIn: composite [ 
	composite list 
		display: [ :smalltalk | {'Classes' -> Object withAllSubclasses} ];
		format: [ :each | each key, ' (', each value size asString ,')' ];
		send: #value;
		when: [:smalltalk | smalltalk == Smalltalk ]
]
