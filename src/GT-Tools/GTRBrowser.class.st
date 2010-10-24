Class {
	#name : #GTRBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #'as yet unclassified' }
GTRBrowser >> buildBrowser [ 
	"self openOn: RPackageOrganizer default"
	browser := GLMTabulator new.
	browser column: #packages; column: #classes.
	browser transmit to: #packages; andShow: [:composite | 
		self packagesIn: composite ].
	browser transmit from: #packages; to: #classes; andShow: [:a | 
		a list 
			display: [:package | package classes ];
			format: [:class :package | 
				(package extendsClass: class) 
					ifTrue: [Text string: class name attribute: TextColor gray]
					ifFalse: [Text fromString: class name] ]].

]

{ #category : #'as yet unclassified' }
GTRBrowser >> packagesIn: composite [
	composite list 
			display: [:organizer | organizer packages sort: [:x :y | x name < y name ]];
			format: [:package | package name ]
]
