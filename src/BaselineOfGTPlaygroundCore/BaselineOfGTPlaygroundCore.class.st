Class {
	#name : #BaselineOfGTPlaygroundCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfGTPlaygroundCore
}

{ #category : #baselines }
BaselineOfGTPlaygroundCore >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'GTInspectorCore' with: [ 
				spec repository: 'github://moosetechnology/gt-v1/src' ].
		spec
		 	package: 'GT-Playground' with: [
				spec requires: #('GTInspectorCore') ];
			package: 'GT-Tests-Playground' with: [
				spec requires: #('GT-Playground') ] ].
]
