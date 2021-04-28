# Boston University's Metropolitan College
## CS665 Assignment Class Project:

### met-cs665-assignment-project-gchriswill

---

## Repository:

This repo holds the source code of the met-cs665-assignment-project-gchriswill project for
[Christopher W. Gonzalez Melendez]'s MET-CS 665 "Software Design and Patterns" class of the  
Software Development Master's degree at Boston University's Metropolitan College.

The purposes of this repo are:

- Provide versioning control features to the project.
- Providing commit history/changelog of the project, for its evaluation by the instructor.
- Use Github's Project, Issues, WIKI and repository management tools.
- Host all the source code remotely on Github as the `remote` repository host.

---

# Project Info:

**Term:** Spring-O2, 2021  
**Project:** met-cs665-assignment-project-gchriswill  
**Instructor:** [Kia Teymourian](http://www.teymourian.de)  
**Facilitator:** Sudakar Sundararajan  
**Institution:** [Boston University's Metropolitan College](https://www.bu.edu/met/)  
**Course:** [CS665 - Software Design and Patterns](http://www.bu.edu/csmet/academic-programs/courses/cs665/)  
**Program:** [Software Development M.Sc. (MSSD)](https://www.bu.edu/met/degrees-certificates/ms-software-development/)  
**Student/Engineer/Developer:** Christopher W. Gonzalez Melendez, D.K.A. "[@gchriswill](https://github.com/gchriswill)"

### IDE Platforms:

- [IntelliJ IDEA Ultimate 2020.3.2](https://www.jetbrains.com/idea/)
- [Xcode 12](https://developer.apple.com/xcode/)

### Development Devices:

- MacBook Pro (15 Inch, 2017)
- iOS 14 Simulator

---

# Project Description


### Application Requirements:


### Assumptions


### Expected Feature Set:

---

# How to compile the project

We use Apache Maven to compile and run this project.

You need to install Apache Maven (https://maven.apache.org/)  on your system.

Type on the command line:

```bash
mvn clean compile
```

# How to create a binary runnable package


```bash
mvn clean compile assembly:single
```


# How to run

```bash
mvn -q clean compile exec:java -Dexec.executable="edu.bu.met.cs665.Main" -Dlog4j.configuration="file:log4j.properties"
```

We recommand the above command for running the Main Java executable.




# Run all the unit test classes.


```bash
mvn clean compile test checkstyle:check  spotbugs:check
```

# Using Spotbugs to find bugs in your project

To see bug detail using the Findbugs GUI, use the following command "mvn findbugs:gui"

Or you can create a XML report by using  


```bash
mvn spotbugs:gui
```

or


```bash
mvn spotbugs:spotbugs
```


```bash
mvn spotbugs:check
```

check goal runs analysis like spotbugs goal, and make the build failed if it found any bugs.


For more info see
https://spotbugs.readthedocs.io/en/latest/maven.html


SpotBugs https://spotbugs.github.io/ is the spiritual successor of FindBugs.


# Run Checkstyle

CheckStyle code styling configuration files are in config/ directory. Maven checkstyle plugin is set to use google code style.
You can change it to other styles like sun checkstyle.

To analyze this example using CheckStyle run

```bash
mvn checkstyle:check
```

This will generate a report in XML format


```bash
target/checkstyle-checker.xml
target/checkstyle-result.xml
```

and the following command will generate a report in HTML format that you can open it using a Web browser.

```bash
mvn checkstyle:checkstyle
```

```bash
target/site/checkstyle.html
```
