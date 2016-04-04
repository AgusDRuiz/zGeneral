package prueba;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import bean.BeanSpring;

public class PruebaSaludo {

    /**
     * @param args
     */
    public static void main(String[] args) {

        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        BeanFactory factory = context;

        BeanSpring miBean = (BeanSpring) factory.getBean("beanSpring");

        System.out.println("Mi bean: " + miBean.getMensaje());

    }
}
