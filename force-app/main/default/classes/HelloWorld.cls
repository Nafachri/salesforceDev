public class HelloWorld {
    
    // Public variables
    public String name;
    public String address;
    public Integer age;
    public String division;
    public Decimal salary;
    
    // Constructor
    /* public HelloWorld(String name, String address, Integer age, String division, Decimal salary) {
        this.name = name;
        this.address = address;
        this.age = age;
        this.division = division;
        this.salary = salary;
    }*/
    
    // Methods
    public String sayHello() {
        return 'Hello World';
    }
    
    public Integer plusPlus(Integer a, Integer b) {
        return a + b;
    }
    
    public Boolean nameCheck(String name) {
        return name == 'Naufal';
    }
    
    public void displayUser() {
        System.debug('User Details: Name = ' + name + ', Address = ' + address +
                     ', Age = ' + age + ', Division = ' + division + ', Salary = ' + salary);
    }
    
    public void showBebasClass() {
        BebasClass privateClass = new BebasClass();
        String getMethodShowString = privateClass.displayName();
        System.debug('BebasClass Output: ' + getMethodShowString);
        String getShowString = showString();
        System.debug('showString Output: ' + getShowString);
    }
    
    private String showString() {
        return 'This is string';
    }
}