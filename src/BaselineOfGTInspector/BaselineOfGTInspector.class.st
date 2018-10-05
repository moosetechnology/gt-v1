Class {
	#name : #BaselineOfGTInspector,
	#superclass : #BaselineOf,
	#category : #BaselineOfGTInspector
}

{ #category : #baselines }
BaselineOfGTInspector >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [
		spec  
			baseline: 'GTInspectorCore' with: [ 
				spec repository: 'github://moosetechnology/gt-v1:pharo6/src' ];  
			baseline: 'Glamour' with: [ 
				spec repository: 'github://moosetechnology/Glamour:pharo6/src' ];
			project: 'Roassal2' with: [
				spec
					className: #ConfigurationOfRoassal2;
					versionString: #'development';
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ];
			project: 'DeepTraverser' with: [
				spec
					className: #ConfigurationOfDeepTraverser;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/DeepTraverser/main/' ].
		spec 
			package: 'GT-InspectorExtensions-CoreRoassal' with: [
				spec requires: #('GTInspectorCore' 'Glamour' 'Roassal2' ) ] ]

]
