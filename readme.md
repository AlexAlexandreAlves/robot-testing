### Run all tests

`robot.`

### Run a single test

`robot {path}/file-example.robot`

### Run and create a test result folder

`robot ./result -t {path}/file-example.robot`    

### Run a single test case into test file

`robot -d {path} -t "CT001: Exemplo de teste" test-file.robot`    

### Run with a custom module in your project

`python -m robot -d {path} -t "CT001: Exemplo de teste" test-file.robot`    