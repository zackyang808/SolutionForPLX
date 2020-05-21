CREATE TABLE [User](
	Id uniqueidentifier NOT NULL PRIMARY KEY NONCLUSTERED,
	Name nvarchar(50) NOT NULL
);

CREATE TABLE Offer(
	Id uniqueidentifier NOT NULL PRIMARY KEY NONCLUSTERED,
	Total decimal(18,2) NOT NULL
);

CREATE TABLE Coupon(
	Id uniqueidentifier NOT NULL PRIMARY KEY NONCLUSTERED,
	Title nvarchar(200) NOT NULL,
	Starts datetime NOT NULL,
	Ends datetime NOT NULL,
	MaxPerUser int NOT NULL,
	MaxOverUsers int NOT NULL,
	IsActive bit NOT NULL
);
CREATE NONCLUSTERED INDEX IX_COUPON_STARTS_ENDS ON Coupon(Starts,Ends);
CREATE NONCLUSTERED INDEX IX_COUPON_ISACTIVE ON Coupon(IsActive);

CREATE TABLE Redemption(
	Id uniqueidentifier NOT NULL PRIMARY KEY NONCLUSTERED,
	OfferId uniqueidentifier NOT NULL FOREIGN KEY REFERENCES Offer(Id),
	CouponId uniqueidentifier NOT NULL FOREIGN KEY REFERENCES Coupon(Id),
	RedeemedBy uniqueidentifier NOT NULL FOREIGN KEY REFERENCES [User](Id),
	RedeemedOn datetime NOT NULL,
);
CREATE NONCLUSTERED INDEX IX_REDEMPTION_OFFERID ON Redemption(OfferId);
CREATE NONCLUSTERED INDEX IX_REDEMPTION_COUPONID ON Redemption(CouponId);
CREATE NONCLUSTERED INDEX IX_REDEMPTION_REDEEMEDBY ON Redemption(RedeemedBy);
CREATE CLUSTERED INDEX CLIX_REDEMPTION_REDEEMEDON ON Redemption(RedeemedOn);

