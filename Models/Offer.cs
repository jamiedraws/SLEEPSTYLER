using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.Base.Models;

namespace SJOXTREAM.Models
{
    public class Offer
    {
        public string ProductCodeSingleOffer { get; set; }
        public string ProductCodeMultiOffer { get; set; }
        public Image Savings { get; set; }

        private bool _isDiscountOffer { get; set; }
        private bool _isMostPopular { get; set; }
        private bool _isBestValue { get; set; }
        private bool _isSpecial { get; set; }
        private bool _isLowOffer { get; set; }

        public Offer ()
        {
            _isDiscountOffer = IsDiscountOffer();
            _isMostPopular = IsMostPopular();
            _isBestValue = IsBestValue();
            _isLowOffer = IsLowOffer();
            _isSpecial = IsSpecial();

            if (_isMostPopular)
            {
                ProductCodeSingleOffer = _isLowOffer ? "MAINMP3LOW" : _isDiscountOffer ? "MAINMPDIS3" : "MAINMP";
                ProductCodeMultiOffer = _isLowOffer ? "AFFMAINMP3LOW" : _isDiscountOffer ? "AFFMAINMPDIS" : "AFFMAINMP";

                Savings = new Image
                {
                    Src = _isLowOffer ? "/images/banner-savings-240.svg" : "/images/banner-savings-230.svg",
                    Alt = _isLowOffer ? "Over $240 in savings!" : "Over $230 in savings!"
                };
            } else if (_isBestValue)
            {
                ProductCodeSingleOffer = _isLowOffer ? "MAINBV3LOW" : _isDiscountOffer ? "MAINBVDIS3" : "MAINBV";
                ProductCodeMultiOffer = _isLowOffer ? "AFFMAINBV3LOW" : _isDiscountOffer ? "AFFMAINBVDIS" : "AFFMAINBV";

                Savings = new Image
                {
                    Src = _isLowOffer ? "/images/banner-savings-300.svg" : "/images/banner-savings-300.svg",
                    Alt = _isLowOffer ? "Over $300 in savings!" : "Over $300 in savings!"
                };
            } else if (_isSpecial)
            {
                ProductCodeSingleOffer = "DOWN1";
                ProductCodeMultiOffer = "AFFDOWN1";

                Savings = new Image
                {
                    Src = _isLowOffer ? "/images/banner-savings-300.svg" : "/images/banner-savings-300.svg",
                    Alt = _isLowOffer ? "Over $300 in savings!" : "Over $300 in savings!"
                };
            } else
            {
                ProductCodeSingleOffer = _isLowOffer ? "MAINTVLOW" : _isDiscountOffer ? "MAINTVDIS" : "MAINTV";
                ProductCodeMultiOffer = _isLowOffer ? "AFFMAINTVLOW" : _isDiscountOffer ? "AFFMAINTVDIS" : "AFFMAINTV";

                Savings = new Image
                {
                    Src = _isLowOffer ? "/images/banner-savings-220.svg" : _isDiscountOffer ? "/images/banner-savings-200.svg" : "/images/banner-savings-180.svg",
                    Alt = _isLowOffer ? "Over $220 in savings!" : _isDiscountOffer ? "Over $200 in savings!" : "Over $180 in savings!"
                };
            }
        }

        public bool IsDiscountOffer ()
        {
            return DtmContext.Version == 8 || DtmContext.Version >= 10;
        }

        public bool IsLowOffer()
        {
            return DtmContext.Version >= 13;
        }

        public bool IsMostPopular ()
        {
            return DtmContext.PageCode == "MostPopular";
        }

        public bool IsBestValue ()
        {
            return DtmContext.PageCode == "BestValue";
        }

        public bool IsSpecial ()
        {
            return DtmContext.Version == 16;
        }
    }

    public class Image
    {
        public string Src { get; set; }
        public string Alt { get; set; }
    }
}