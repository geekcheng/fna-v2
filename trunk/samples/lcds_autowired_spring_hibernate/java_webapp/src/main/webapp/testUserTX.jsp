<%@ page import="javax.transaction.UserTransaction" %> 

<%@ page import="javax.naming.InitialContext" %> 

<%@ page import="javax.naming.Context" %> 

<body>

 

start<br>

<%

        try

        {

            Context ctx = new InitialContext();

 

            String userTransactionJndi = "java:comp/UserTransaction";

            String userSpecified = System.getProperty("UserTxJndiName");

            if (userSpecified != null)

            {

                userTransactionJndi = userSpecified;

            }

            Object userTransactionObject =  ctx.lookup(userTransactionJndi);
            
            out.println("userTransactionObject type :"+userTransactionObject.getClass().getName()+"<br>");
            out.println("userTransactionObject implements UserTransaction :"+ (userTransactionObject instanceof UserTransaction)+"<br>");
            
            //UserTransaction userTransaction = (UserTransaction)userTransactionObject;

            if (userTransactionObject != null)

            {
            	out.println("beginning<br>");

            	((UserTransaction)userTransactionObject).begin();

                out.println("begin ok!<br>");

                ((UserTransaction)userTransactionObject).commit();

                out.println("commit ok!<br>");

            }

            else

            {

                out.println("returned null");

            }

        }

        catch (Exception ne)

        {

            out.println("ERROR : "+ne.toString());

        }

%>

 

done

 

</body>
