@gherkin4
Feature: Outputting row elements

  The output of an element model is a representation of the element as it would
  appear in gherkin.


  Scenario: Output of a row that has one cell
    Given a row element based on the following gherkin:
    """
    |value|
    """
    When it is outputted
    Then the following text is provided:
    """
    | value |
    """

  Scenario: Output of a row that has multiple cells
    Given a row element based on the following gherkin:
    """
    |value|another_value|
    """
    When it is outputted
    Then the following text is provided:
    """
    | value | another_value |
    """
