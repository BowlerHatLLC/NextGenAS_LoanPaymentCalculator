package
{
	public class LoanPaymentCalculator
	{
		public function LoanPaymentCalculator()
		{
			var calculatorForm:HTMLFormElement = document.getElementById("calculator-form") as HTMLFormElement;
			calculatorForm.addEventListener("submit", form_submitHandler, false);

			this._principalInput = document.getElementById("principal-input") as HTMLInputElement;
			this._interestInput = document.getElementById("interest-input") as HTMLInputElement;
			this._yearsInput = document.getElementById("years-input") as HTMLInputElement;
			this._paymentResultSpan = document.getElementById("result-text") as HTMLSpanElement;
		}

		private var _principalInput:HTMLInputElement;
		private var _interestInput:HTMLInputElement;
		private var _yearsInput:HTMLInputElement;
		private var _paymentResultSpan:HTMLSpanElement;

		private function calculatePayment(principal:Number, interestRate:Number, years:int):Number
		{
			var effectiveInterestRate:Number = (interestRate / 100) / 12;
			var totalPaymentCount:int = years * 12;
			return principal * (effectiveInterestRate / (1 - Math.pow(1 + effectiveInterestRate, -totalPaymentCount)))
		}

		private function form_submitHandler(event:Event):void
		{
			event.preventDefault();

			var principal:Number = parseFloat(this._principalInput.value);
			var interestRate:Number = parseFloat(this._interestInput.value);
			var years:int = parseInt(this._yearsInput.value, 10);
			var payment:Number = calculatePayment(principal, interestRate, years);
			this._paymentResultSpan.textContent = payment.toFixed(2);
		}
	}
}
