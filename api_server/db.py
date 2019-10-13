import sqlite3
import datetime

class Interface:
        
    
    def connect_db(self):
        print("Connecting to db")
        try: 
            self.conn = sqlite3.connect('mydb6.db',check_same_thread=False)      
            print("Connection Sucessfull")
        except:
            print("Error in Connectinf to Db")
    
    
    
    def exec(self,q):
        print("Trying to exec query , creating cursor....")
        print("Query: ",q)
        self.cur=self.conn.cursor() #create cursor obj
        try:
            self. cur.execute(q)
            print("Query exec sucess!!")
        except Exception as e:
            print("Error in Query exec========================")
            print(e)
        self.conn.commit()
        self.cur.close()
        print("Cursor Deleted")
        
        
    def create_table_cust(self):
        a="""
        Create Table Cust(
	name varchar(30),
	phone varchar(13)  Primary Key,
	password varchar(300),
	points int default 0,
    negative_points int default 0,
    aadhar_id varchar(14),
    foreign key (aadhar_id) references Aadhar(aadhar_id)
    );"""
        self.exec(a)
    
    def create_table_report(self):
        b="""
    Create Table Report(
    report_id varchar(100) Primary Key ,
    type varchar(15),
    text varchar(250),
    img_path varchar(100),
    location varchar(60),
    done boolean default false
    );"""
        self.exec(b)
            
    def create_table_joining(self):
        c="""
    Create Table Joining(
    report_id varchar(100),
    phone varchar(13),
    primary key(report_id,phone));"""  
        self.exec(c)

         
    
    def register(self,name,phone,password,aadhar_id):
        print("Trying to register")
        e=f"""
        insert into Cust(name,phone,password,aadhar_id)
        values('{name}','{phone}','{password}','{aadhar_id}');
        """
        self.exec(e)
        
        
    def login(self,phone):
        ##spl case not calling exec fn, using direct execute as to get res
        print("Trying to login")
        f=f"""
        select * from Cust where phone = {phone};
        """
        
        cur=self.conn.cursor()  
        cur.execute(f)
        res=cur.fetchall()
        if len(res)==0:
            print("Accout dosent exist")
            cur.close()
            return None
        else:print("Welcome ",res[0][1])
        cur.close()
        return res[0][2]
    
    def suggest(self,phone,title,text):
        print("Creating Suggest report")
        now = datetime.datetime.now()
        now=str(now.timestamp())
        text=title+": "+text
        print("timestamp=",now)
        print("text=",text)
        
        f=f"insert into Report values('{now}','sugg','{text}',NULL,NULL,{True});"
        self.exec(f)
        return self.points(phone,1)

    def plastic_store(self,phone,store_name,address,location=None):
        print("Creating Plastic_Store report")
        now = datetime.datetime.now()
        now=now.timestamp()
        text=store_name+": "+address
        print("timestamp=",now)
        print("text=",text)
        
        f=f"insert into Report values('{now}','store_plastic','{text}',NULL,NULL,{True});"
        self.exec(f)
        self.points(phone,3)

    def dump(self,phone,address,location=None):
        print("Creating dump report")
        now = datetime.datetime.now()
        now=now.timestamp()
        print("timestamp=",now)
        print("text=",address)
        
        f=f"insert into Report values('{now}','dump','{address}',NULL,NULL,{True});"
        self.exec(f)
        self.points(phone,2)
        
    def points(self,phone,point_0):
        print("Increasing user points")
        f=f"""update cust set points=points+{point_0} where phone={phone};"""
        self.exec(f)
        f=f"""select points from Cust where phone = {phone};"""
        cur=self.conn.cursor()  
        cur.execute(f)
        res=cur.fetchall()
        return res[0][0] # new points
        
    def ret_leaderboard(self):
        f=f"""select points,name from Cust
        order by points desc limit 3"""
        cur=self.conn.cursor()  
        cur.execute(f)
        res=cur.fetchall()
        return res
    
    def close(self):
        self.conn.close()
        
    def create_table_aadhar(self):
        d="""
    Create Table Aadhar(
    aadhar_id int primary key,
    phone varchar(12));"""  
        self.exec(d)  
        
        q="insert into Aadhar values('{}', '{}')"
        records = [(123456,456),(123457,457)]
        for r in records:
            self.exec(q.format(r[0],r[1]))
        
    # DUMMY DATA for real UIDAI DATABASE
        


# =============================================================================
# =============================================================================
# inf=Interface()
# inf.connect_db()
# inf.ret_leaderboard()
# =============================================================================
# 
# inf.create_table_aadhar()
# inf.create_table_cust()
# inf.create_table_report()
# inf.create_table_joining()
# =============================================================================

#inf.register('aaaa','9865235222','pasasawaord','5000069852')
#inf.login('9865235222')
#inf.suggest('9865235222','tile000','texthere00000')
#inf.plastic_store('9865235222','gg_store','plastic exeis2525')
#inf.dump('9865235222','dirty testing poi00')

# =============================================================================
# inf.close()
# =============================================================================