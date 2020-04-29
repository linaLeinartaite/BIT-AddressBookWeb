
package lt.bit.data;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 *
 * @author Lina
 */
public class DB {

    //DB_CONNECTION
    public static List<Person> getPersons(Connection con) {
        try (
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from person order by first_name");) {
            List<Person> l = new ArrayList<>();
            while (rs.next()) {
                Person p = new Person();
                p.setId(rs.getInt("id"));
                p.setFirstName(rs.getString("first_name"));
                p.setLastName(rs.getString("last_name"));
                p.setBirthDate(rs.getDate("birth_date"));                
                p.setSalary(rs.getBigDecimal("salary"));
                l.add(p);
            }
            return l;
        } catch (Exception ex) {
            ex.printStackTrace();
            return new ArrayList<>();
        }
    }
    
         public static List<Address> getAddresses(Connection con, Integer id) {
        try (
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(
                        "select * from address where address.person_id=" +id 
                       + " order by city;"
                );) {
            List<Address> l = new ArrayList<>();
            while (rs.next()) {
                Address a = new Address();
                a.setId(rs.getInt("id"));
                a.setPersonId(rs.getInt("person_id"));
                a.setAddress(rs.getString("address"));
                a.setCity(rs.getString("city"));
                a.setPostCode(rs.getString("postal_code"));
                l.add(a);
            }           
            return l;
        } catch (Exception ex) {
            ex.printStackTrace();
            return new ArrayList<>();
        }
    }

        public static List<Contact> getContacts(Connection con, Integer id) {
        try (
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(
                        "select * from contact where person_id=" +id
                                
                                +" order by contact_type;"                      
                );) {
            List<Contact> l = new ArrayList<>();
            while (rs.next()) {
                Contact c = new Contact();
                c.setId(rs.getInt("id"));
                c.setPersonId(rs.getInt("person_id"));
                c.setType(rs.getString("contact_type"));
                c.setContact(rs.getString("contact"));
                l.add(c);
            }
            return l;
        } catch (Exception ex) {
            ex.printStackTrace();
            return new ArrayList<>();
        }
    }   

    public static Person getPerson(Connection con, Integer id) {
        try (
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from person where id = " + id);) {
            if (rs.next()) {
                Person p = new Person();
                p.setId(rs.getInt("id"));
                p.setFirstName(rs.getString("first_name"));
                p.setLastName(rs.getString("last_name"));
                p.setBirthDate(rs.getDate("birth_date"));
                p.setSalary(rs.getBigDecimal("salary"));
                return p;
            }
            return null;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public static Address getAddress(Connection con, Integer id) {
        try (
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * "
                        + "from address "
                        + "where id = " + id);) {
            if (rs.next()) {
                Address a = new Address();
                a.setId(rs.getInt("id"));
                a.setPersonId(rs.getInt("person_id"));
                a.setAddress(rs.getString("address"));
                a.setCity(rs.getString("city"));
                a.setPostCode("postal_code");
                return a;
            }
            return null;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public static Contact getContact(Connection con, Integer id) {
        try (
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from contact where id = " + id);) {
            if (rs.next()) {
                Contact c = new Contact();
                c.setId(rs.getInt("id"));
                c.setPersonId(rs.getInt("person_id"));
                c.setType(rs.getString("contact_type"));
                c.setContact(rs.getString("contact"));
                return c;
            }
            return null;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public static void addPerson(Connection con, Person p) {
        try (PreparedStatement st = con.prepareStatement("insert into person "
                + "(first_name, last_name, birth_date, salary) values (?, ?, ?, ?)");) {
            st.setString(1, p.getFirstName());
            st.setString(2, p.getLastName());
            if (p.getBirthDate() != null) {
                Calendar cal = Calendar.getInstance();
                cal.setTime(p.getBirthDate());
                cal.set(Calendar.HOUR, 12);
                cal.set(Calendar.MINUTE, 0);
                cal.set(Calendar.SECOND, 0);
                cal.set(Calendar.MILLISECOND, 0);
                java.sql.Date bd = new java.sql.Date(cal.getTimeInMillis());
                st.setDate(3, bd);
                System.out.println("DATE NOT NULL: " + bd);
            } else {
                st.setNull(3, Types.DATE);
                 System.out.println("DATE NULL: ");
            }
            if (p.getSalary() != null) {
                st.setBigDecimal(4, p.getSalary());
            } else {
                st.setNull(4, Types.DECIMAL);
            }
            st.execute();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static void addAddress(Connection con, Integer idP, Address a) {
        Person p = getPerson(con, idP);
        if (p == null) {
            return;
        }
        try (PreparedStatement st = con.prepareStatement("insert into address "
                + "( person_id, address, city, postal_code) values (?, ?, ?, ?)");) {
            st.setInt(1, idP);
            st.setString(2, a.getAddress());
            st.setString(3, a.getCity());
            if (a.getPostCode().equals("") || a.getPostCode()==null) {
                st.setNull(4, java.sql.Types.VARCHAR);
            } else {
                st.setString(4, a.getPostCode());
            }
                st.execute();
            }catch (Exception ex) {
            ex.printStackTrace();
        }
        }

    

    public static void addContact(Connection con, Integer idP, Contact c) {
        Person p = getPerson(con, idP);
        if (p == null) {
            return;
        }
        try (PreparedStatement st = con.prepareStatement("insert into contact "
                + "( person_id, contact_type, contact) values (?, ?, ?)");) {
            st.setInt(1, idP);
            st.setString(2, c.getType());
            st.setString(3, c.getContact());
            st.execute();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static void removePerson(Connection con, Integer id) {
        try (PreparedStatement st = con.prepareStatement("delete from person where id = ?");) {
            st.setInt(1, id);
            st.execute();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static void removeAddress(Connection con, Integer id) {
        if (id == null) {
            return;
        }
        try (PreparedStatement st = con.prepareStatement("delete from address"
                + " where id = ?");) {
            st.setInt(1, id);
            st.execute();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static void removeContact(Connection con, Integer id) {
        if (id == null) {
            return;
        }
        try (PreparedStatement st = con.prepareStatement("delete from contact"
                + " where id = ?");) {
            st.setInt(1, id);
            st.execute();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }

    public static void updatePerson(Connection con, Person up) {
        try (PreparedStatement st = con.prepareStatement("update person "
                + "set first_name = ?, last_name = ?, birth_date = ?, salary = ? "
                + "where id = ?");) {
            st.setString(1, up.getFirstName());
            st.setString(2, up.getLastName());
            if (up.getBirthDate() != null) {
                Calendar cal = Calendar.getInstance();
                cal.setTime(up.getBirthDate());
                cal.set(Calendar.HOUR, 12);
                cal.set(Calendar.MINUTE, 0);
                cal.set(Calendar.SECOND, 0);
                cal.set(Calendar.MILLISECOND, 0);
                java.sql.Date bd = new java.sql.Date(cal.getTimeInMillis());
                st.setDate(3, bd);
            } else {
                st.setNull(3, Types.DATE);
            }
            if (up.getSalary() != null) {
                st.setBigDecimal(4, up.getSalary());
            } else {
                st.setNull(4, Types.DECIMAL);
            }
            st.setInt(5, up.getId());
            st.execute();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static void updateAddress(Connection con, Address na) {
        if (na == null || na.getId() == null) {
            return;
        }
        Address a = getAddress(con, na.getId());
        if (a == null) {
        }
        try (PreparedStatement st = con.prepareStatement("update address set "
                + "person_id = ?, address = ?, city = ?, postal_code = ? "
                + "where id = ?");) {

            st.setInt(1, na.getPersonId());
            st.setString(2, na.getAddress());
            st.setString(3, na.getCity());
            
//            if (na.getPostCode() != null) {
//                st.setString(4, na.getPostCode());
//            } else {
//                System.out.println("TIPAS??");
//                st.setNull(4, java.sql.Types.VARCHAR);
//            }

            if (na.getPostCode().equals("")|| na.getPostCode()==null) {
                st.setNull(4, java.sql.Types.VARCHAR);
            } else {          
                st.setString(4, na.getPostCode());
            }
            st.setInt(5, na.getId());

            st.execute();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static void updateContact(Connection con, Contact ca) {
        if (ca == null || ca.getId() == null) {
            return;
        }
        Address a = getAddress(con, ca.getId());
        if (a == null) {
        }
        try (PreparedStatement st = con.prepareStatement("update contact set "
                + " person_id = ?, contact_type = ?, contact = ? "
                + " where id = ?");) {
            st.setInt(1, ca.getPersonId());
            st.setString(2, ca.getType());
            st.setString(3, ca.getContact());
            st.setInt(4, ca.getId());

            st.execute();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    } 
}
