Bambu
===========

![](https://travis-ci.com/leonardocouy/bambu.svg?token=bxrKZyktZHisKxWszFGt&branch=master)

![](https://giphy.com/embed/LE5bApm6m0HrG)

## Bambu? What the fuck???

Bambu has been **inspired in Pandas** (Python package). But, Bambu **aims only** for provide a flexible, manipulable and nice structure **like DataFrame** in Pandas, for an unstructured data.

This project was thought during Kata practice to improve my Ruby programming skills. At this Kata session, I had developed a Data Munging (clean and transform data to a readable and manipulable format) solution for two unstructured datasets. So, when I solved these problems, I saw both solutions and I reached a conclusion! I could make a gem that can read any unstructured data on condition that that user tells how he wants to manipulate this file.

Gem name is how it is pronounced in Brazilian Portuguese and another motive for this name it is a way to refer to Pandas (Python package) and panda likes to eat bamboo. We can compare a bamboo plantation with a structured data and realize that you have data without structure imbalance equal a bamboo plantation that has a regular plantation, in other words, the bamboo plantation is a structured plantation that contains bamboos with regular height and width, and spacing between them. As a result, bamboos get arranged like data structured.

#### Keep calm, Bambu hasn't released yet

![](http://media.giphy.com/media/LE5bApm6m0HrG/200.gif)

## Bambu's goals

- Provides a good way to read and manipulate unstructured data;
- Modularize and isolate whenever possible;
- No dependencies (avoid ActiveSupport, etc.);
- Following ruby best practices;
- TDD (Test first!).

## Bambu's modules

- **Reader** (in progress)
  - **Responsibility** for reading raw unstructured data based on user's condition and transform to **Bambu readable format structure**.
- **Mapper** (not developed yet)
  - This module hopes that data has a structure preferably a **Bambu Structure**, but, **might support** other **structures like ActiveRecord::Relation, Struct and etc**.
  - Gives Bambu's power to structure.
- **ResultSet (not an official name, suggestions plzzz)**
  - Should have as input a Bambu structured format (provided by Bambu Reader and Mapper).
  - Bambu's ResultSet implements functions for end-use, if you want to show some data from your Bambu structured format in your Rails application, for example, you may provide through ResultSet.

## Roadmap

Bambu isn't my main focus, but intention is that this roadmap should be followed whenever possible

- Refactor Bambu::Reader;
- Read-only CSV file in Reader module;
- Mapper modeling;
- Initialize Mapper module;
- Mapper reads different source types, but, priorize ActiveRecord::Relation;
- Mapper should provide ways to change column names;
- Mapper should provide ways to infer column types;
- Mapper should provide ways to deal with missing data;
- ResultSet modeling;
- Initialize ResultSet module;
- ResultSet should provide ways to get min value of a column.
- ResultSet should provide ways to get max value of a column.
- ResultSet should provide ways to get the sum of all values of a column.
- ResultSet should provide ways to get avg value of a column.
- ResultSet should provide ways to get descriptive statistics of a column or all.
- Release beta version
- Create demo example
- Create webapp demonstrating use of Bambu
- My **P.O side** will be thinking about more features :D...;

## Developing

**Assuming that you are using RVM**

1. Clone the repo

```bash
git clone https://github.com/leonardocouy/bambu
```

2. Make sure you run ruby 2.4.2

```bash
rvm install ruby-2.4.2
```

3. Go to Bambu's project folder and ensure that you are using specified Ruby version.

```bash
rvm use ruby-2.4.2
```

4. Run!

#### How to run tests?

```bash
rake test
```

## May the Bambu with you!

Contribute to Bambu through pull requests! 

If you have a suggestion, creates an issue!

## License

This project is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

