"
self open
"
Class {
	#name : #GTMetaceller,
	#superclass : #GLMGlobalBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #building }
GTMetaceller >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Metacello Browser'.
	browser column: #configs; column: #details span: 4.
	self toConfigsAndShow.
	self toDetailsFromConfigsAndShow.
	^ browser 
]

{ #category : #opening }
GTMetaceller >> entity [ 
	^ (Object subclasses select: [:each | (each class canUnderstand: #isMetacelloConfig) and: [
			each isMetacelloConfig ] ]) sort: [:a :b | a name < b name]
]

{ #category : #private }
GTMetaceller >> shortNameOf: config [
	"self new shortNameOf: ConfigurationOfAlien"
	^ ((config name beginsWith: 'ConfigurationOf') 
		ifTrue: [config name copyFrom: 'ConfigurationOf' size + 1 to: config name size ] 
		ifFalse: [config name]) asString
]

{ #category : #building }
GTMetaceller >> toConfigsAndShow [
	browser transmit to: #configs; andShow: [ :a |
		| configList |
		a title: 'Configurations'.
		configList := a list
			format: [:configClass | | text label version |
				label := self shortNameOf: configClass.
				version := configClass project currentVersion.
				text := version notNil
					ifTrue: [ (label, ' [', version versionString, ']') ]
					ifFalse: [ Text string: label attribute: TextColor gray].
				text ];
			act: [:list  | list selection browse ] entitled: 'Browse implementation';
			act: [:list  | list selection project inspect] entitled: 'Inspect'.
			Smalltalk at: #OBCmdMetacello ifPresent: [ :x |
				configList actions: [:list | 
					(GTOBCommandAdaptor new 
						actionsFrom: (Smalltalk at: #OBCmdMetacello) subclasses 
						on: list selection 
						for: nil ) do: [:each | each category: 'OB Commands'] ] ] ]
]

{ #category : #building }
GTMetaceller >> toDetailsFromConfigsAndShow [
	browser transmit from: #configs->#strongSelection; to: #details; andShowWithoutOverride: [ :a |
		a custom: (GTMetacellerDetails new browser noTitle)
		].
	browser transmit from: #configs; to: #details->#entityToSelect.
]
