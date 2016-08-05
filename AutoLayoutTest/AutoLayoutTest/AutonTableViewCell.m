//
//  AutonTableViewCell.m
//  AutoLayoutTest
//
//  Created by damon on 16/8/5.
//  Copyright © 2016年 yaocaimaimai. All rights reserved.
//

#import "AutonTableViewCell.h"
#import "Masonry.h"

@interface AutonTableViewCell ()

@property (nonatomic, strong)  UILabel *titleLabel;
@property (nonatomic, strong)  UILabel *contentLabel;
@property (nonatomic, strong)  UIImageView *contentImageView;
@property (nonatomic, strong)  UILabel *usernameLabel;
@property (nonatomic, strong)  UILabel *timeLabel;

@end

@implementation AutonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createViews];
        [self setViewAutoLayout];
    }
    return self ;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)createViews {
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    _contentLabel = [UILabel new];
    [self.contentView addSubview:_contentLabel];
    
    _contentLabel.numberOfLines = 0 ;
    
    
    _contentImageView = [UIImageView new];
    [self.contentView addSubview:_contentImageView];
    
    
    _usernameLabel = [UILabel new];
    [self.contentView addSubview:_usernameLabel];
    _timeLabel = [UILabel new];
    [self.contentView addSubview:_timeLabel];
    
}

- (void)setViewAutoLayout {
    
    int magin = 4 ;
    int padding = 10 ;
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(self.contentView).offset(padding);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-padding);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.equalTo(_titleLabel);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(magin);
    }];
    
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.mas_equalTo(_contentLabel.mas_bottom).offset(magin);
        
    }];
    
    [_usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        
        make.top.mas_equalTo(_contentImageView.mas_bottom).offset(magin);
        
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-magin);
        
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.and.top.equalTo(_usernameLabel);
        make.right.equalTo(_titleLabel.mas_right);
    }];

    
}

- (void)setEntity:(FDFeedEntity *)entity
{
    _entity = entity;
    
    self.titleLabel.text = entity.title;
    self.contentLabel.text = entity.content;
    self.contentImageView.image = entity.imageName.length > 0 ? [UIImage imageNamed:entity.imageName] : nil;
    self.usernameLabel.text = entity.username;
    self.timeLabel.text = entity.time;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
